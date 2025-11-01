# DAQ-ANDI 📊

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/Python-3.x-blue.svg)](https://www.python.org/)
[![MikroC](https://img.shields.io/badge/MikroC-Compiler-orange.svg)](https://www.mikroe.com/mikroc)
[![FreeRTOS](https://img.shields.io/badge/FreeRTOS-Embedded-green.svg)](https://www.freertos.org/)

Sistema de Adquisición de Datos (DAQ) y Control basado en microcontrolador PIC 18F4550 con protocolo HID, implementado con FreeRTOS y MikroC. Incluye interfaz gráfica en Python para visualización y análisis en tiempo real.

## 📋 Tabla de Contenidos

- [Características](#características)
- [Arquitectura del Sistema](#arquitectura-del-sistema)
- [Requisitos](#requisitos)
- [Instalación](#instalación)
- [Uso](#uso)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Tecnologías](#tecnologías)
- [Contribuir](#contribuir)
- [Licencia](#licencia)
- [Autor](#autor)

## Características

### Hardware (Firmware PIC)
- **Adquisición de datos** analógicos y digitales en tiempo real
- **Control de salidas** analógicas (PWM) y digitales
- **Comunicación USB** mediante protocolo HID (sin drivers adicionales)
- **Sistema operativo en tiempo real** (FreeRTOS) para gestión de tareas
- **Basado en PIC 18F4550** (8-bit, hasta 48 MHz)

### Software (Interfaz Python)
- **Interfaz gráfica intuitiva** desarrollada con PyQt5
- **Visualización en tiempo real** de señales con pyqtgraph
- **Exportación de datos** a formato Excel (.xlsx)
- **Soporte para expresiones matemáticas** en procesamiento de comandos
- **Configuración flexible** de entradas/salidas
- **Gráficas interactivas** con zoom y desplazamiento

## Arquitectura del Sistema

```
┌─────────────────────────────────────────────────┐
│           Interfaz Gráfica (Python)             │
│  ┌──────────────┐  ┌────────────────────────┐  │
│  │   daq_gui.py │  │  Visualización PyQt5   │  │
│  └──────┬───────┘  └────────────────────────┘  │
│         │                                        │
│  ┌──────▼──────────────────────────────────┐   │
│  │  rt_daq_interface.py (Tiempo Real)      │   │
│  └──────┬──────────────────────────────────┘   │
│         │                                        │
│  ┌──────▼──────────────────────────────────┐   │
│  │  daq_interface.py (Comunicación Base)   │   │
│  └──────┬──────────────────────────────────┘   │
└─────────┼──────────────────────────────────────┘
          │ USB HID Protocol
┌─────────▼──────────────────────────────────────┐
│        Hardware PIC 18F4550 + FreeRTOS         │
│  ┌─────────────┐  ┌──────────────────────┐    │
│  │  Firmware   │  │  Gestión de Tareas   │    │
│  │  (MikroC)   │  │     (FreeRTOS)       │    │
│  └─────────────┘  └──────────────────────┘    │
│                                                 │
│  ┌─────────────────────────────────────────┐  │
│  │  ADC  │  GPIO  │  PWM  │  Timers        │  │
│  └─────────────────────────────────────────┘  │
└─────────────────────────────────────────────────┘
```

## Requisitos

### Hardware
- **Microcontrolador:** PIC 18F4550
- **Programador:** PICkit 3/4 o compatible
- **Conexión USB** para comunicación con PC
- **Fuente de alimentación:** 5V
- **Componentes adicionales** según aplicación (sensores, actuadores, etc.)

### Software

#### Desarrollo de Firmware
- **MikroC PRO for PIC** (compilador C para PIC)
- **FreeRTOS** (incluido en el proyecto)
- Programador de microcontroladores (PICkit, etc.)

#### Interfaz Gráfica Python
- **Python 3.x** (recomendado 3.7 o superior)
- **Librerías Python:**
  - `PyQt5` - Framework de interfaz gráfica
  - `pyqtgraph` - Visualización de gráficas en tiempo real
  - `numpy` - Operaciones numéricas
  - `openpyxl` - Manejo de archivos Excel

## Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/paradoxelite/DAQANDI.git
cd DAQANDI
```

### 2. Configurar el Firmware (PIC)

1. Abrir el proyecto en **MikroC PRO for PIC**
2. Configurar los fuses del microcontrolador según tu hardware
3. Compilar el proyecto
4. Programar el PIC 18F4550 con el archivo `.hex` generado

### 3. Instalar Dependencias Python

```bash
# Usando pip
pip install PyQt5 pyqtgraph numpy openpyxl

# O usando requirements.txt (si existe)
pip install -r requirements.txt
```

### 4. Verificar Conexión USB

Conectar el dispositivo PIC 18F4550 al puerto USB. El sistema operativo debería reconocerlo como dispositivo HID (no requiere drivers adicionales en Windows/Linux/macOS).

## Uso

### Iniciar la Interfaz Gráfica

```bash
python daq_gui.py
```

### Flujo de Trabajo Típico

1. **Conectar** el dispositivo DAQ al puerto USB
2. **Iniciar** la aplicación `daq_gui.py`
3. **Configurar** los canales analógicos/digitales a monitorear
4. **Configurar** las salidas (PWM, digitales) si es necesario
5. **Iniciar** la adquisición de datos
6. **Visualizar** las señales en tiempo real
7. **Exportar** los datos a Excel si es necesario
8. **Detener** la adquisición cuando termine

### Ejemplo de Uso de Módulos

```python
from daq_interface import DAQInterface

# Crear instancia de comunicación
daq = DAQInterface()

# Conectar al dispositivo
if daq.connect():
    # Leer canal analógico 0
    value = daq.read_analog(0)
    print(f"Valor analógico: {value}")

    # Escribir salida digital
    daq.write_digital(pin=5, value=True)

    # Configurar PWM
    daq.set_pwm(duty_cycle=50)
```

## Estructura del Proyecto

```
DAQANDI/
├── firmware/               # Código del microcontrolador
│   ├── src/               # Archivos fuente en C (MikroC)
│   ├── FreeRTOS/          # Sistema operativo en tiempo real
│   └── config/            # Configuraciones del PIC
│
├── software/              # Interfaz Python
│   ├── daq_gui.py        # Interfaz gráfica principal
│   ├── rt_daq_interface.py   # Comunicación en tiempo real
│   └── daq_interface.py  # Módulo base de comunicación
│
├── docs/                  # Documentación adicional
├── examples/              # Ejemplos de uso
└── README.md             # Este archivo
```

## Tecnologías

### Embedded Systems
| Tecnología | Versión | Propósito |
|-----------|---------|-----------|
| **PIC 18F4550** | - | Microcontrolador principal (8-bit, 48MHz) |
| **MikroC PRO** | - | Compilador C para PIC |
| **FreeRTOS** | - | Sistema operativo en tiempo real |
| **USB HID** | 2.0 | Protocolo de comunicación |

### Software Desktop
| Tecnología | Versión | Propósito |
|-----------|---------|-----------|
| **Python** | 3.x | Lenguaje de programación |
| **PyQt5** | - | Framework GUI |
| **pyqtgraph** | - | Gráficas en tiempo real |
| **NumPy** | - | Procesamiento numérico |
| **openpyxl** | - | Exportación a Excel |

## Contribuir

Las contribuciones son bienvenidas! Por favor:

1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## Autor

**Jose Rodolfo Gomez Coeto**

- GitHub: [@paradoxelite](https://github.com/paradoxelite)

---

⭐ Si este proyecto te fue útil, considera darle una estrella en GitHub!
