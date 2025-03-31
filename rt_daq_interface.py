import time
import numpy as np
import queue
import math
from daq_interface import DAQInterface

class RTDAQInterface:
    def __init__(self):
        self.daq = DAQInterface()
        self.read_sampling_period = 0.0002  # 200 microsegundos para lectura
        self.write_sampling_period = 0.00001  # 10 microsegundos para escritura
        self.data_queue = queue.Queue()
        self.write_queue = queue.Queue()
        self.running = False
        self.waveform_running = False
        self.last_read_time = 0
        self.last_write_time = 0
        
    def connect_device(self):
        """Connect to the DAQ device"""
        try:
            if not self.daq.connect_device():
                print("Failed to connect to DAQ device")
                return False
            return True
        except Exception as e:
            print(f"Error connecting to device: {e}")
            return False
            
    def read_data(self):
        """Read data from all channels"""
        try:
            # Read all channels sequentially
            for i in range(1, 5):
                try:
                    value = self.daq.read_analog(i)
                    if value is not None:
                        self.data_queue.put_nowait((f'AN{i}', value))
                except Exception as e:
                    print(f"Error reading AN{i}: {e}")
            
            # Read digital value
            try:
                value = self.daq.read_digital(6)
                if value is not None:
                    self.data_queue.put_nowait(('DIG', value))
            except Exception as e:
                print(f"Error reading digital: {e}")
                
        except Exception as e:
            print(f"Error in read_data: {e}")
            
    def write_data(self):
        """Write data from queue"""
        try:
            # Procesar cola de escritura
            while not self.write_queue.empty():
                channel, value = self.write_queue.get_nowait()
                if channel.startswith('AN'):
                    self.write_analog(int(channel[2:]), value)
                elif channel == 'DIG':
                    self.write_digital(int(value), 6)
        except Exception as e:
            print(f"Error in write_data: {e}")
                
    def write_analog_time_function(self, channel, function_type, frequency, amplitude, offset):
        """Write time-based function to analog channel"""
        try:
            self.waveform_running = True
            start_time = time.perf_counter()
            
            while self.waveform_running:
                current_time = time.perf_counter() - start_time
                
                # Calcular valor según la función
                if function_type == "sine":
                    value = amplitude * math.sin(2 * math.pi * frequency * current_time) + offset
                elif function_type == "square":
                    value = amplitude * (1 if math.sin(2 * math.pi * frequency * current_time) >= 0 else -1) + offset
                elif function_type == "triangle":
                    value = amplitude * (2 * abs(2 * (frequency * current_time - math.floor(frequency * current_time + 0.5))) - 1) + offset
                else:  # sawtooth
                    value = amplitude * (2 * (frequency * current_time - math.floor(frequency * current_time)) - 1) + offset
                
                # Escribir valor
                self.write_analog(channel, value)
                
                # Esperar hasta el siguiente intervalo
                next_time = time.perf_counter() + self.write_sampling_period
                while time.perf_counter() < next_time:
                    pass
                    
        except Exception as e:
            print(f"Error in time function generation: {e}")
        finally:
            self.waveform_running = False
                
    def stop_waveform(self):
        """Stop waveform generation"""
        self.waveform_running = False
            
    def read_analog(self, channel):
        """Read analog value from specified channel"""
        try:
            return self.daq.read_analog(channel)
        except Exception as e:
            print(f"Error reading analog channel {channel}: {e}")
            return None
            
    def read_digital(self, port):
        """Read digital value from specified port"""
        try:
            return self.daq.read_digital(port)
        except Exception as e:
            print(f"Error reading digital port {port}: {e}")
            return None
            
    def write_analog(self, channel, value):
        """Write analog value to specified channel"""
        try:
            return self.daq.write_analog(channel, value)
        except Exception as e:
            print(f"Error writing analog channel {channel}: {e}")
            return False
            
    def write_digital(self, value, port):
        """Write digital value to specified port"""
        try:
            return self.daq.write_digital(value, port)
        except Exception as e:
            print(f"Error writing digital port {port}: {e}")
            return False
            
    def close(self):
        """Close DAQ connection"""
        try:
            self.daq.close()
            return True
        except Exception as e:
            print(f"Error closing connection: {e}")
            return False 