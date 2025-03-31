import hid
import sys
import time
import traceback
import math
import threading

class DAQInterface:
    def __init__(self, vendor_id=0x1234, product_id=0x0001):
        self.vendor_id = vendor_id
        self.product_id = product_id
        self.device = None
        self.debug = True  # Enable debugging by default
        self.current_buffer = bytearray(64)  # Buffer interno para mantener valores
        self.current_buffer[0] = 0x01  # Report ID siempre en 0x01
        self.wave_threads = {}  # Diccionario para almacenar los threads por canal
        self.stop_flags = {}    # Diccionario para flags de detención por canal
        self.connect_device()

    def debug_print(self, message):
        """Print debug messages if debugging is enabled"""
        if self.debug:
            print(f"DEBUG: {message}")

    def connect_device(self):
        try:
            self.debug_print("Attempting to connect to device...")
            
            # List all HID devices
            print("\nAvailable HID devices:")
            for device in hid.enumerate():
                print(f"VID: 0x{device['vendor_id']:04x}, PID: 0x{device['product_id']:04x}")
                print(f"Manufacturer: {device.get('manufacturer_string', 'N/A')}")
                print(f"Product: {device.get('product_string', 'N/A')}")
                print("---")
            
            # Get device info
            device_info = hid.enumerate(self.vendor_id, self.product_id)
            if not device_info:
                print(f"\nNo device found with VID: 0x{self.vendor_id:04x}, PID: 0x{self.product_id:04x}")
                print("Please check if:")
                print("1. The device is connected")
                print("2. The device is recognized by the system")
                print("3. The VID and PID are correct")
                return False
                
            self.debug_print(f"Found device: {device_info[0]}")
            
            # Try to open device
            self.device = hid.device()
            self.device.open(self.vendor_id, self.product_id)
            
            # Get report descriptor
            report_descriptor = self.device.get_report_descriptor()
            self.debug_print(f"Report descriptor: {report_descriptor}")
            
            # Get device info
            self.debug_print(f"Manufacturer: {self.device.get_manufacturer_string()}")
            self.debug_print(f"Product: {self.device.get_product_string()}")
            self.debug_print(f"Serial: {self.device.get_serial_number_string()}")
            
            # Set non-blocking mode
            self.device.set_nonblocking(True)
            
            print("Device connected successfully")
            return True
            
        except Exception as e:
            print(f"Error connecting to device: {e}")
            self.debug_print("Stack trace:")
            traceback.print_exc()
            return False

    def write_digital(self, value, byte_position):
        try:
            self.debug_print(f"Preparing to write value: {value} to byte {byte_position}")
            
            # Ensure value is an integer
            value = int(value)
            if not 0 <= value <= 255:
                print("Value must be between 0 and 255")
                return False
            
            if not 2 <= byte_position <= 6:
                print("Byte position must be between 2 and 6")
                return False
            
            # Actualizar solo el byte específico en el buffer interno
            self.current_buffer[byte_position] = value
            
            self.debug_print(f"Current buffer: {list(self.current_buffer)}")
            self.debug_print(f"Buffer type: {type(self.current_buffer)}")
            self.debug_print(f"Buffer length: {len(self.current_buffer)}")
            self.debug_print(f"Report ID: {self.current_buffer[0]}")
            self.debug_print(f"Value position: byte {byte_position} = {self.current_buffer[byte_position]}")
            
            # Write to device
            bytes_written = self.device.write(self.current_buffer)  # Enviar buffer completo
            self.debug_print(f"Write result: {bytes_written}")
            
            if bytes_written < 0:
                print(f"Error: Write failed with return value {bytes_written}")
                return False
            
            # Add a small delay to ensure the device processes the data
            time.sleep(0.00005)
                
            print(f"Sent value: {value} (0x{value:02X}) to byte {byte_position}")
            print("Value will be maintained until buffer is reset or byte is changed")
            return True
        except Exception as e:
            print(f"Error writing to device: {e}")
            self.debug_print("Stack trace:")
            traceback.print_exc()
            return False

    def write_analog(self, channel, value):
        try:
            # Detener la generación de ondas solo para este canal si existe
            if channel in self.wave_threads and self.wave_threads[channel].is_alive():
                self.stop_flags[channel] = True
                self.wave_threads[channel].join()
                del self.wave_threads[channel]
                del self.stop_flags[channel]
            
            # Ensure value is a float
            value = float(value)
            if not -5 <= value <= 5:
                print("Value must be between -5 and 5")
                return False
            
            # Map -5 to 5 range to 0 to 255
            mapped_value = int(((value + 5) / 10) * 255)
            
            # Map channel to byte position
            channel_map = {
                1: 2,  # AN1 -> byte 2
                2: 3,  # AN2 -> byte 3
                3: 4,  # AN3 -> byte 4
                4: 5   # AN4 -> byte 5
            }
            
            if channel not in channel_map:
                print("Channel must be between 1 and 4")
                return False
            
            byte_position = channel_map[channel]
            
            # Actualizar solo el byte específico en el buffer interno
            self.current_buffer[byte_position] = mapped_value
            
            self.debug_print(f"Analog value: {value}V mapped to: {mapped_value}")
            self.debug_print(f"Writing to channel AN{channel} (byte {byte_position})")
            self.debug_print(f"Current buffer: {list(self.current_buffer)}")
            
            # Write to device
            bytes_written = self.device.write(self.current_buffer)
            self.debug_print(f"Write result: {bytes_written}")
            
            if bytes_written < 0:
                print(f"Error: Write failed with return value {bytes_written}")
                return False
            
            time.sleep(0.00005)
            print(f"Sent analog value: {value}V (mapped to {mapped_value}) to AN{channel}")
            print("Value will be maintained until buffer is reset or channel is changed")
            return True
            
        except ValueError:
            print("Please enter a valid number")
            return False
        except Exception as e:
            print(f"Error writing analog value: {e}")
            self.debug_print("Stack trace:")
            traceback.print_exc()
            return False

    def write_analog_time_function(self, channel, function_type, frequency=1.0, amplitude=5.0, offset=0.0):
        """Write analog value based on time function"""
        try:
            if not 1 <= channel <= 4:
                print("Channel must be between 1 and 4")
                return False
                
            # Map channel to byte position
            channel_map = {
                1: 2,  # AN1 -> byte 2
                2: 3,  # AN2 -> byte 3
                3: 4,  # AN3 -> byte 4
                4: 5   # AN4 -> byte 5
            }
            
            byte_position = channel_map[channel]
            start_time = time.time()
            
            print(f"\nGenerating {function_type} wave on AN{channel}")
            print(f"Frequency: {frequency} Hz")
            print(f"Amplitude: {amplitude}V")
            print(f"Offset: {offset}V")
            print("Wave generation will continue until buffer is reset or channel is changed")
            
            def wave_generator():
                while not self.stop_flags.get(channel, False):
                    current_time = time.time() - start_time
                    
                    # Calculate value based on function type
                    if function_type == "sine":
                        value = amplitude * math.sin(2 * math.pi * frequency * current_time) + offset
                    elif function_type == "square":
                        value = amplitude * (1 if math.sin(2 * math.pi * frequency * current_time) >= 0 else -1) + offset
                    elif function_type == "triangle":
                        period = 1 / frequency
                        t = current_time % period
                        if t < period/2:
                            value = amplitude * (2 * t / period) + offset
                        else:
                            value = amplitude * (2 - 2 * t / period) + offset
                    elif function_type == "sawtooth":
                        period = 1 / frequency
                        t = current_time % period
                        value = amplitude * (2 * t / period - 1) + offset
                    
                    # Clamp value between -5 and 5
                    value = max(min(value, 5.0), -5.0)
                    
                    # Map -5 to 5 range to 0 to 255
                    mapped_value = int(((value + 5) / 10) * 255)
                    
                    # Update buffer and write to device
                    self.current_buffer[byte_position] = mapped_value
                    bytes_written = self.device.write(self.current_buffer)
                    
                    if bytes_written < 0:
                        print(f"Error: Write failed with return value {bytes_written}")
                        return
                    
                    # Small delay to control update rate
                    time.sleep(0.00005)
            
            # Detener el thread anterior para este canal si existe
            if channel in self.wave_threads and self.wave_threads[channel].is_alive():
                self.stop_flags[channel] = True
                self.wave_threads[channel].join()
            
            # Reiniciar el flag y crear nuevo thread para este canal
            self.stop_flags[channel] = False
            self.wave_threads[channel] = threading.Thread(target=wave_generator)
            self.wave_threads[channel].daemon = True  # El thread se cerrará cuando el programa principal termine
            self.wave_threads[channel].start()
            
            return True
                
        except Exception as e:
            print(f"Error generating waveform: {e}")
            self.debug_print("Stack trace:")
            traceback.print_exc()
            return False

    def close(self):
        if self.device:
            self.device.close()
            print("Device closed")

    def check_device_status(self):
        """Check device status and configuration"""
        try:
            if not self.device:
                print("Device not connected")
                return False
                
            # Get device info
            print("\nDevice Information:")
            print(f"Manufacturer: {self.device.get_manufacturer_string()}")
            print(f"Product: {self.device.get_product_string()}")
            print(f"Serial: {self.device.get_serial_number_string()}")
            
            # Get report descriptor
            report_descriptor = self.device.get_report_descriptor()
            print(f"\nReport Descriptor: {report_descriptor}")
            
            # Print current buffer state
            print("\nCurrent Buffer State:")
            print(f"Buffer: {list(self.current_buffer)}")
            
            # Print device configuration
            print("\nDevice Configuration:")
            print(f"Vendor ID: 0x{self.vendor_id:04x}")
            print(f"Product ID: 0x{self.product_id:04x}")
            print(f"Buffer Size: 64 bytes")
            print(f"Report ID: 0x01")
            
            return True
        except Exception as e:
            print(f"Error checking device status: {e}")
            self.debug_print("Stack trace:")
            traceback.print_exc()
            return False

    def reset_buffer(self):
        """Reset all buffer values to 0 except Report ID"""
        try:
            # Detener todos los threads de generación de ondas
            for channel in list(self.wave_threads.keys()):
                if self.wave_threads[channel].is_alive():
                    self.stop_flags[channel] = True
                    self.wave_threads[channel].join()
            
            # Limpiar los diccionarios de threads y flags
            self.wave_threads.clear()
            self.stop_flags.clear()
            
            # Mantener el Report ID en 0x01
            self.current_buffer = bytearray(64)
            self.current_buffer[0] = 0x01
            
            # Enviar el buffer reiniciado al dispositivo
            bytes_written = self.device.write(self.current_buffer)
            self.debug_print(f"Write result after reset: {bytes_written}")
            
            if bytes_written < 0:
                print(f"Error: Reset failed with return value {bytes_written}")
                return False
            
            print("Buffer reset successfully")
            return True
        except Exception as e:
            print(f"Error resetting buffer: {e}")
            self.debug_print("Stack trace:")
            traceback.print_exc()
            return False

    def read_digital(self, byte_position):
        """Read digital value from specified byte position"""
        try:
            if not 2 <= byte_position <= 6:
                print("Byte position must be between 2 and 6")
                return None
            
            # Read from device
            data = self.device.read(64)  # El método read devuelve una lista de bytes
            
            if not data:  # Si no hay datos
                print("No data received from device")
                return None
            
            # Convertir la lista a bytearray
            data = bytearray(data)
            
            value = data[byte_position]
            self.debug_print(f"Read value: {value} (0x{value:02X}) from byte {byte_position}")
            return value
            
        except Exception as e:
            print(f"Error reading from device: {e}")
            self.debug_print("Stack trace:")
            traceback.print_exc()
            return None

    def read_digital_realtime(self, byte_position):
        """Read digital value in real-time until interrupted"""
        try:
            if not 2 <= byte_position <= 6:
                print("Byte position must be between 2 and 6")
                return False
            
            print(f"\nReading digital value from byte {byte_position}")
            print("Press Ctrl+C to stop")
            
            while True:
                value = self.read_digital(byte_position)
                if value is not None:
                    print(f"Value: {value} (0x{value:02X})", end='\r')
                time.sleep(0.1)  # Update every 100ms
                
        except KeyboardInterrupt:
            print("\nStopping digital read")
            return True
        except Exception as e:
            print(f"Error in real-time read: {e}")
            self.debug_print("Stack trace:")
            traceback.print_exc()
            return False

    def read_analog(self, byte_position):
        """Read analog value from specified byte position and map to 0-5V"""
        try:
            if not 1 <= byte_position <= 5:
                print("Byte position must be between 1 and 5")
                return None
            
            # Read from device
            data = self.device.read(64)  # El método read devuelve una lista de bytes
            
            if not data:  # Si no hay datos
                print("No data received from device")
                return None
            
            # Convertir la lista a bytearray
            data = bytearray(data)
            
            # Obtener el valor del byte y mapearlo a 0-5V
            # El ADC es de 10 bits (0-1023), y estamos tomando los 8 bits superiores
            raw_value = data[byte_position]  # Valor de 8 bits (0-255)
            voltage = (raw_value / 255.0) * 5.0  # Mapeo de 0-255 a 0-5V
            
            self.debug_print(f"Raw value: {raw_value} (0x{raw_value:02X}) from byte {byte_position}")
            self.debug_print(f"Mapped to voltage: {voltage:.3f}V")
            return voltage
            
        except Exception as e:
            print(f"Error reading from device: {e}")
            self.debug_print("Stack trace:")
            traceback.print_exc()
            return None

    def read_analog_realtime(self, byte_position):
        """Read analog value in real-time until interrupted"""
        try:
            if not 1 <= byte_position <= 5:
                print("Byte position must be between 1 and 5")
                return False
            
            print(f"\nReading analog value from byte {byte_position}")
            print("Press Ctrl+C to stop")
            
            while True:
                voltage = self.read_analog(byte_position)
                if voltage is not None:
                    print(f"Voltage: {voltage:.3f}V", end='\r')
                time.sleep(0.1)  # Update every 100ms
                
        except KeyboardInterrupt:
            print("\nStopping analog read")
            return True
        except Exception as e:
            print(f"Error in real-time read: {e}")
            self.debug_print("Stack trace:")
            traceback.print_exc()
            return False

def main():
    daq = DAQInterface()
    
    if not daq.connect_device():
        print("Failed to connect to device")
        return
        
    try:
        while True:
            print("\nDAQ Interface Menu:")
            print("1. Digital Outputs")
            print("2. Analog Outputs")
            print("3. Digital Inputs")
            print("4. Analog Inputs")
            print("5. Check Device Status")
            print("6. Reset Buffer")
            print("7. Exit")
            
            choice = input("Enter your choice (1-7): ")
            
            if choice == "1":
                print("\nDigital Outputs")
                print("Enter value for byte 6 (0-255):")
                try:
                    value = int(input("Value: "))
                    if 0 <= value <= 255:
                        if daq.write_digital(value, 6):
                            print(f"Successfully wrote value: {value} to byte 6")
                        else:
                            print("Failed to write value")
                    else:
                        print("Value must be between 0 and 255")
                except ValueError:
                    print("Please enter a valid integer")
                    
            elif choice == "2":
                print("\nAnalog Outputs")
                print("1. Set static value")
                print("2. Generate time function")
                subchoice = input("Enter your choice (1-2): ")
                
                if subchoice == "1":
                    print("Enter channel (1-4) and value (-5 to 5):")
                    try:
                        channel = int(input("Channel (1-4): "))
                        value = float(input("Value (-5 to 5): "))
                        if 1 <= channel <= 4:
                            if daq.write_analog(channel, value):
                                print(f"Successfully wrote value: {value}V to AN{channel}")
                            else:
                                print("Failed to write value")
                        else:
                            print("Channel must be between 1 and 4")
                    except ValueError:
                        print("Please enter valid numbers")
                        
                elif subchoice == "2":
                    print("\nTime Function Generator")
                    try:
                        channel = int(input("Channel (1-4): "))
                        print("\nFunction types:")
                        print("1. Sine wave")
                        print("2. Square wave")
                        print("3. Triangle wave")
                        print("4. Sawtooth wave")
                        func_choice = input("Select function type (1-4): ")
                        
                        function_types = {
                            "1": "sine",
                            "2": "square",
                            "3": "triangle",
                            "4": "sawtooth"
                        }
                        
                        if func_choice not in function_types:
                            print("Invalid function type")
                            continue
                            
                        frequency = float(input("Enter frequency (Hz): "))
                        amplitude = float(input("Enter amplitude (V, max 5): "))
                        offset = float(input("Enter offset (V): "))
                        
                        # Clamp amplitude to 5V
                        amplitude = min(amplitude, 5.0)
                        
                        daq.write_analog_time_function(
                            channel,
                            function_types[func_choice],
                            frequency,
                            amplitude,
                            offset
                        )
                        
                    except ValueError:
                        print("Please enter valid numbers")
                    except KeyboardInterrupt:
                        print("\nOperation cancelled")
                else:
                    print("Invalid choice")
                    
            elif choice == "3":
                print("\nDigital Inputs")
                print("1. Read current value")
                print("2. Read in real-time")
                subchoice = input("Enter your choice (1-2): ")
                
                if subchoice == "1":
                    value = daq.read_digital(6)
                    if value is not None:
                        print(f"Current value from byte 6: {value} (0x{value:02X})")
                elif subchoice == "2":
                    daq.read_digital_realtime(6)
                else:
                    print("Invalid choice")
                    
            elif choice == "4":
                print("\nAnalog Inputs")
                print("1. Read current value")
                print("2. Read in real-time")
                subchoice = input("Enter your choice (1-2): ")
                
                if subchoice == "1":
                    print("\nSelect byte position (1-5):")
                    try:
                        byte_pos = int(input("Byte position: "))
                        if 1 <= byte_pos <= 5:
                            voltage = daq.read_analog(byte_pos)
                            if voltage is not None:
                                print(f"Current voltage from byte {byte_pos}: {voltage:.3f}V")
                        else:
                            print("Byte position must be between 1 and 5")
                    except ValueError:
                        print("Please enter a valid number")
                elif subchoice == "2":
                    print("\nSelect byte position (1-5):")
                    try:
                        byte_pos = int(input("Byte position: "))
                        if 1 <= byte_pos <= 5:
                            daq.read_analog_realtime(byte_pos)
                        else:
                            print("Byte position must be between 1 and 5")
                    except ValueError:
                        print("Please enter a valid number")
                else:
                    print("Invalid choice")
                    
            elif choice == "5":
                daq.check_device_status()
                
            elif choice == "6":
                if daq.reset_buffer():
                    print("Buffer reset to 0 (except Report ID)")
                else:
                    print("Failed to reset buffer")
                    
            elif choice == "7":
                break
                
            else:
                print("Invalid choice")
                
    finally:
        daq.close()
        
if __name__ == "__main__":
    main() 