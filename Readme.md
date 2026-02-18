# Trisquel Ecne server

## Objetivo
Este repositorio proporciona una colección de guiones (scripts) de 
configuración para el despliegue de un servidor de acceso público. El 
proyecto está diseñado con un enfoque modular que permite tanto la puesta en 
marcha de servicios como el endurecimiento (hardening) del sistema, 
garantizando un entorno robusto y seguro.

Es totalmente compatible con las distribuciones:
* Trisquel 11 Ecne
* Ubuntu 24.04 Noble Numbat
* Debian 13 Trixie

## Instalación y despliegue
Para asegurar el correcto funcionamiento de las rutas internas, el repositorio 
debe alojarse en la ruta local del sistema. Siga estos pasos:

1.  Clonar el repositorio:
    ```console
    cd /var/local/
    sudo git clone 
[https://github.com/usuario/trisquel-ecne-server.git](https://github.com/usuario
/trisquel-ecne-server.git)
    cd trisquel-ecne-server
    ```

2.  Ejecución de guiones:
    Los guiones se ejecutan de forma individual según las necesidades del 
administrador. Por ejemplo:
    ```console
    sudo bash nombre-del-guion.sh
    ```
    *(Se recomienda revisar el contenido de cada guion antes de su ejecución).*

## Dependencias
Para iniciar el proceso, el sistema debe contar con las siguientes herramientas 
básicas:

* git: Para la clonación y gestión del repositorio.
* bash: Intérprete de comandos para la ejecución de los guiones.

> Nota: No es necesario instalar manualmente las dependencias de red o 
servicios específicos, ya que los propios guiones se encargan de gestionar e 
instalar los paquetes necesarios durante su ejecución.

## Licencia
trisquel-ecne-server se distribuye bajo la licencia GPLv3.
Consulte el fichero `LICENSE` para más detalles.
