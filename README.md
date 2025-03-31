# DAQ-ANDI

Sistema de adquisición de datos y control basado en un PIC con protocolo HID.
## Características

- Interfaz gráfica para visualización en tiempo real
- Adquisición de datos analógicos y digitales
- Control de salidas analógicas y digitales
- Visualización de datos mediante gráficas en tiempo real
- Guardado de datos en formato Excel
- Soporte para expresiones matemáticas en comandos

## Requisitos

- Python 3.x
- PyQt5
- pyqtgraph
- numpy
- openpyxl

## Instalación

1. Clonar el repositorio:
```bash
git clone https://github.com/joser/DAQ-ANDI.git
```

2. Instalar las dependencias:
```bash
pip install -r requirements.txt
```

## Uso

1. Conectar el dispositivo DAQ
2. Ejecutar la interfaz gráfica:
```bash
python daq_gui.py
```

3. Configurar los comandos de salida según sea necesario
4. Iniciar la medición y visualización de datos
5. Guardar los datos cuando sea necesario

## Estructura del Proyecto

- `daq_gui.py`: Interfaz gráfica principal
- `rt_daq_interface.py`: Interfaz en tiempo real con el dispositivo DAQ
- `daq_interface.py`: Interfaz base con el dispositivo DAQ

## Licencia

Este proyecto está bajo la Licencia MIT.

## Autor

Tu Nombre 
