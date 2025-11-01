# DAQ-ANDI

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/Python-3.x-blue.svg)](https://www.python.org/)
[![MikroC](https://img.shields.io/badge/MikroC-PIC-orange.svg)](https://www.mikroe.com/mikroc)
[![OSA](https://img.shields.io/badge/RTOS-OSA-green.svg)](http://www.pic24.ru/doku.php/en/osa/ref/intro/oview)

Sistema de Adquisición de Datos (DAQ) y Control basado en microcontrolador PIC 18F4550 con protocolo USB HID. Implementa un sistema operativo en tiempo real (OSA) y una interfaz gráfica en Python para visualización y control en tiempo real.

## Características

### Hardware (Firmware PIC)
- **5 canales analógicos** de entrada (10-bit ADC)
- **8 bits de entrada digital** (PORTB)
- **8 bits de salida digital** con multiplexación (PORTD)
- **Comunicación USB HID** (sin necesidad de drivers adicionales)
- **Sistema operativo en tiempo real OSA** para gestión de 3 tareas concurrentes
- **Basado en PIC 18F4550** (8-bit, hasta 48 MHz, USB 2.0)

### Software (Interfaz Python)
- **Interfaz gráfica intuitiva** desarrollada con PyQt5
- **Visualización en tiempo real** de señales analógicas con pyqtgraph
- **Exportación de datos** a formato Excel (.xlsx)
- **Generación de formas de onda** (seno, cuadrada, triangular, rampa)
- **Control de salidas digitales** por byte o individual
- **Gráficas interactivas** con zoom, desplazamiento y múltiples trazas
- **Comunicación USB HID** mediante librería hidapi

## Arquitectura del Sistema

```
┌─────────────────────────────────────────────────────────┐
│              Interfaz Gráfica (Python)                  │
│                                                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │  daq_gui.py - Interfaz Gráfica Principal         │  │
│  │  - Visualización en tiempo real                  │  │
│  │  - Configuración de canales                      │  │
│  │  │  - Exportación a Excel                         │  │
│  └──────────────┬───────────────────────────────────┘  │
│                 │                                        │
│  ┌──────────────▼───────────────────────────────────┐  │
│  │  rt_daq_interface.py - Interfaz Tiempo Real      │  │
│  │  - Lectura continua de datos                     │  │
│  │  - Buffer circular para muestras                 │  │
│  └──────────────┬───────────────────────────────────┘  │
│                 │                                        │
│  ┌──────────────▼───────────────────────────────────┐  │
│  │  daq_interface.py - Comunicación USB HID         │  │
│  │  - Lectura/escritura de buffers                  │  │
│  │  - Generación de formas de onda                  │  │
│  └──────────────┬───────────────────────────────────┘  │
└─────────────────┼───────────────────────────────────────┘
                  │ USB HID Protocol (hidapi)
┌─────────────────▼───────────────────────────────────────┐
│         Hardware PIC 18F4550 + RTOS OSA                 │
│                                                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │  MyProject.c - Firmware Principal                │  │
│  │                                                   │  │
│  │  Thread 1: USB Polling (USB_Polling_Proc)        │  │
│  │  Thread 2: Lectura ADC y envío de datos          │  │
│  │  Thread 3: Recepción y control de salidas        │  │
│  └──────────────────────────────────────────────────┘  │
│                                                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │  OSA Kernel (BSD License)                        │  │
│  │  - Scheduler cooperativo                         │  │
│  │  - Task timers y delays                          │  │
│  │  - 3 tareas concurrentes                         │  │
│  └──────────────────────────────────────────────────┘  │
│                                                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │  Periféricos                                     │  │
│  │  ADC: AN5, AN2, AN4, AN7, AN6 (10-bit)           │  │
│  │  Digital In: PORTB (8 bits)                      │  │
│  │  Digital Out: PORTD (8 bits con multiplexación)  │  │
│  │  USB: Módulo USB integrado (HID)                 │  │
│  └──────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────┘
```

## Requisitos

### Hardware
- **Microcontrolador:** PIC 18F4550 (DIP-40 o TQFP-44)
- **Programador:** PICkit 3/4, ICD3 o compatible
- **Cristal:** 20 MHz (para USB)
- **Conexión USB:** Cable USB tipo A-B o mini/micro USB
- **Fuente de alimentación:** 5V (puede ser alimentado por USB)
- **Componentes adicionales opcionales:**
  - Sensores analógicos (0-5V)
  - Interruptores/pulsadores para entradas digitales
  - LEDs o relés para salidas digitales

### Software

#### Desarrollo de Firmware
- **MikroC PRO for PIC** (compilador C para PIC)
- **OSA RTOS** (incluido en el proyecto - carpeta `Programa PIC/osa`)
- **Programador compatible** con PIC (PICkit, MPLAB ICD, etc.)

#### Interfaz Gráfica Python
- **Python 3.7 o superior**
- **Librerías Python** (ver `requirements.txt`):
  - `PyQt5 >= 5.15.0` - Framework de interfaz gráfica
  - `pyqtgraph >= 0.13.3` - Visualización de gráficas en tiempo real
  - `numpy >= 1.21.0` - Operaciones numéricas
  - `openpyxl >= 3.0.7` - Manejo de archivos Excel
  - `hidapi >= 0.14.0` - Comunicación con dispositivos HID

## Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/paradoxelite/DAQANDI.git
cd DAQANDI
```

### 2. Configurar el Firmware (PIC)

1. Abrir **MikroC PRO for PIC**
2. Abrir el proyecto en la carpeta `Programa PIC`
3. Configurar los fuses del microcontrolador:
   - Oscillator: HS (20 MHz con PLL para 48 MHz)
   - Habilitar USB
   - Deshabilitar watchdog timer
   - Habilitar Low Voltage Programming si es necesario
4. Compilar el proyecto (Build)
5. Programar el PIC 18F4550 con el archivo `.hex` generado

### 3. Instalar Dependencias Python

```bash
# Instalar desde requirements.txt
pip install -r requirements.txt

# O instalar manualmente cada paquete
pip install PyQt5 pyqtgraph numpy openpyxl hidapi
```

### 4. Verificar Conexión USB

1. Conectar el dispositivo PIC 18F4550 al puerto USB
2. En Windows: El sistema debería reconocerlo automáticamente como dispositivo HID
3. En Linux: Puede requerir permisos udev (ver sección de troubleshooting)
4. En macOS: Debería funcionar sin configuración adicional

**Identificadores del dispositivo:**
- Vendor ID (VID): `0x1234`
- Product ID (PID): `0x0001`

## Uso

### Iniciar la Interfaz Gráfica

```bash
python daq_gui.py
```

### Flujo de Trabajo Típico

1. **Conectar** el dispositivo DAQ al puerto USB
2. **Iniciar** la aplicación ejecutando `python daq_gui.py`
3. **Verificar conexión** - El dispositivo debería conectarse automáticamente
4. **Configurar canales analógicos** - Seleccionar cuáles visualizar
5. **Monitorear entradas digitales** - PORTB (8 bits)
6. **Controlar salidas digitales** - PORTD (8 bits)
7. **Generar formas de onda** (opcional) en las salidas
8. **Visualizar** las señales en tiempo real en las gráficas
9. **Exportar datos** a Excel si es necesario
10. **Detener** la adquisición cuando termine

### Ejemplo de Uso Programático

```python
from daq_interface import DAQInterface

# Crear instancia de comunicación
daq = DAQInterface(vendor_id=0x1234, product_id=0x0001)

# Verificar conexión
if daq.device:
    print("Dispositivo conectado")

    # Leer datos del dispositivo
    data = daq.device.read(64)
    if data:
        # data[1] a data[5] contienen valores de ADC (0-255)
        adc_ch1 = data[1]
        adc_ch2 = data[2]
        adc_ch3 = data[3]
        adc_ch4 = data[4]
        adc_ch5 = data[5]
        digital_in = data[6]  # Estado de PORTB

        print(f"Canales ADC: {adc_ch1}, {adc_ch2}, {adc_ch3}, {adc_ch4}, {adc_ch5}")
        print(f"Entradas digitales: 0b{digital_in:08b}")

    # Escribir salida digital
    buffer = bytearray(64)
    buffer[0] = 0x01  # Report ID
    buffer[1] = 0xFF  # Valor para PORTD (todos los bits en alto)
    daq.device.write(buffer)
```

### Generación de Formas de Onda

```python
from daq_interface import DAQInterface

daq = DAQInterface()

# Generar onda senoidal en salida digital (byte 1)
# Frecuencia: 1 Hz, Amplitud: 0-255, Offset: 128
daq.write_wave(
    wave_type='sine',      # 'sine', 'square', 'triangle', 'ramp'
    frequency=1.0,         # Hz
    amplitude=127,         # 0-255
    offset=128,           # 0-255
    byte_position=1       # Posición en el buffer (1-5)
)

# Detener la generación de onda en byte 1
daq.stop_wave(byte_position=1)
```

## Estructura del Proyecto

```
DAQANDI/
├── Programa PIC/              # Firmware del microcontrolador
│   ├── MyProject.c           # Código principal del firmware
│   ├── MyProject.mcppi       # Proyecto MikroC
│   ├── MyProject.hex         # Archivo compilado para programar
│   ├── OSAcfg.h              # Configuración del RTOS OSA
│   ├── USBdsc.c              # Descriptores USB
│   └── osa/                  # Kernel OSA (BSD License)
│       ├── kernel/           # Núcleo del sistema operativo
│       │   ├── system/       # Sistema base (tasks, scheduler)
│       │   ├── events/       # Eventos (semáforos, colas, etc.)
│       │   └── timers/       # Temporizadores del sistema
│       └── example/          # Ejemplos para diferentes compiladores
│
├── daq_gui.py                # Interfaz gráfica principal (PyQt5)
├── daq_interface.py          # Comunicación USB HID base
├── rt_daq_interface.py       # Interfaz de tiempo real
├── requirements.txt          # Dependencias Python
├── icon.ico                  # Icono de la aplicación (Windows)
├── icon.png                  # Icono de la aplicación (otros)
├── LICENSE                   # Licencia MIT del proyecto
└── README.md                 # Este archivo
```

## Protocolo de Comunicación

### Formato de Datos USB HID

**Buffer de Lectura (PIC → PC):** 64 bytes
```
Byte 0:  Report ID (0x01)
Byte 1:  Canal ADC AN5 (0-255)
Byte 2:  Canal ADC AN2 (0-255)
Byte 3:  Canal ADC AN4 (0-255)
Byte 4:  Canal ADC AN7 (0-255)
Byte 5:  Canal ADC AN6 (0-255)
Byte 6:  Estado de PORTB (8 bits digitales)
Byte 7-63: Reservado
```

**Buffer de Escritura (PC → PIC):** 64 bytes
```
Byte 0:  Report ID (0x01)
Byte 1-4: Valores para multiplexación de PORTD
Byte 5:  Valor directo para PORTD
Byte 6-63: Reservado
```

## Tecnologías Utilizadas

### Embedded Systems
| Tecnología | Versión/Modelo | Propósito |
|-----------|----------------|-----------|
| **PIC 18F4550** | 8-bit, 48 MHz | Microcontrolador principal con USB |
| **MikroC PRO** | - | Compilador C para PIC |
| **OSA RTOS** | - | Sistema operativo cooperativo (BSD License) |
| **USB HID** | 2.0 Full Speed | Protocolo de comunicación sin drivers |

### Software Desktop
| Tecnología | Versión Mínima | Propósito |
|-----------|----------------|-----------|
| **Python** | 3.7+ | Lenguaje de programación |
| **PyQt5** | 5.15.0 | Framework GUI multiplataforma |
| **pyqtgraph** | 0.13.3 | Gráficas rápidas en tiempo real |
| **NumPy** | 1.21.0 | Procesamiento numérico y arrays |
| **openpyxl** | 3.0.7 | Lectura/escritura de archivos Excel |
| **hidapi** | 0.14.0 | Interfaz para dispositivos USB HID |

## Troubleshooting

### Linux: Permisos para acceder al dispositivo HID

Si obtienes errores de permisos, crea una regla udev:

```bash
# Crear archivo de regla udev
sudo nano /etc/udev/rules.d/99-pic-daq.rules

# Agregar la siguiente línea:
SUBSYSTEM=="usb", ATTRS{idVendor}=="1234", ATTRS{idProduct}=="0001", MODE="0666"

# Recargar reglas udev
sudo udevadm control --reload-rules
sudo udevadm trigger

# Reconectar el dispositivo
```

### Windows: Dispositivo no detectado

1. Verificar en el Administrador de Dispositivos
2. Debe aparecer como "Dispositivo de interfaz humana (HID)"
3. Si aparece como "Dispositivo desconocido", verificar la programación del firmware

### La interfaz gráfica no inicia

```bash
# Verificar instalación de PyQt5
python -c "import PyQt5; print(PyQt5.__version__)"

# Si falla, reinstalar
pip uninstall PyQt5
pip install PyQt5
```

### No se reciben datos del dispositivo

1. Verificar que el LED indicador en RC6 esté funcionando
2. Usar un programa de prueba de HID (como `hidtest`)
3. Verificar los VID/PID en el código Python

## Contribuir

Las contribuciones son bienvenidas! Por favor:

1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/MejorFeature`)
3. Commit tus cambios (`git commit -m 'Agrega MejorFeature'`)
4. Push a la rama (`git push origin feature/MejorFeature`)
5. Abrir un Pull Request

### Áreas de Mejora
- Soporte para más canales analógicos
- Configuración de frecuencia de muestreo
- Filtros digitales en tiempo real
- Triggers y captura de eventos
- Calibración de canales analógicos
- Soporte para otros microcontroladores PIC

## Licencias

### Proyecto DAQ-ANDI
Este proyecto está bajo la **Licencia MIT**. Ver el archivo [LICENSE](LICENSE) para más detalles.

### OSA RTOS
El sistema operativo OSA está bajo **Licencia BSD** (Copyright Victor Timofeev).
Ver `Programa PIC/osa/license.txt` para más detalles.

## Referencias

- [MikroC PRO for PIC](https://www.mikroe.com/mikroc-pic)
- [PIC 18F4550 Datasheet](https://ww1.microchip.com/downloads/en/devicedoc/39632e.pdf)
- [OSA RTOS Documentation](http://www.pic24.ru/doku.php/en/osa/ref/intro/oview)
- [PyQt5 Documentation](https://www.riverbankcomputing.com/static/Docs/PyQt5/)
- [pyqtgraph Documentation](https://pyqtgraph.readthedocs.io/)
- [USB HID Specification](https://www.usb.org/hid)

## Autor

**Jose Rodolfo Gomez Coeto**

- GitHub: [@paradoxelite](https://github.com/paradoxelite)
- Proyecto: [DAQANDI](https://github.com/paradoxelite/DAQANDI)

---

Si este proyecto te fue útil, considera darle una estrella en GitHub!
