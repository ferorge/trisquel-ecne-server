# Trisquel Ecne server

## Objetivo
Este repositorio proporciona una colección de guiones (scripts) de  
configuración para el despliegue de un servidor de acceso público.  
El proyecto está diseñado con un enfoque modular que permite tanto la puesta  
en marcha de servicios como el endurecimiento (hardening) del sistema,  
garantizando un entorno robusto y seguro.  

Es compatible con las distribuciones:  
* Trisquel 11 Ecne
* Ubuntu 24.04 Noble Numbat
* Debian 13 Trixie

## Instalación y despliegue
El repositorio debe alojarse en la ruta local del sistema.  

1. Clonar el repositorio:  
```console
    cd /var/local/
    sudo git clone https://git.sobnix.ar/ferorge/trisquel-ecne-server
```

2. Ejecutar los guiones individualmente según tus necesidades. Por ejemplo:  
```console
    sudo /var/local/trisquel-ecne-server/570.Creacion-de-bienvenida.sh
```

## Dependencias
El sistema debe contar con las siguientes herramientas básicas:  

* git: Para la clonación y gestión del repositorio.
* bash: Intérprete de comandos para la ejecución de los guiones.

## Licencia
trisquel-ecne-server se distribuye bajo la licencia GPLv3.  
Consulte el fichero `LICENSE` para más detalles.  
