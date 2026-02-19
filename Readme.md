# Trisquel Ecne server

## Objetivo
Esta suite contiene una colección de scripts avanzados en Bash diseñados para  
transformar una instalación base de Trisquel Ecne en un servidor de acceso  
público robusto, siguiendo principios de seguridad proactiva y soberanía  
tecnológica.  
Está diseñado con un enfoque modular que permite tanto la puesta en marcha de  
servicios como el endurecimiento (_hardening_) del sistema.  
                                                                                    
Es compatible con las distribuciones:  
* Trisquel 11 Ecne
* Ubuntu 24.04 Noble Numbat
* Debian 13 Trixie

## Funcionalidades principales  
* Provisionamiento automatizado: configuración inicial de red, hostname y  
repositorios oficiales.  
* Hardening del sistema:
    * Restricción de permisos en sistemas de archivos.  
    * Configuración segura de SSH (deshabilitación de root login, cambio de  
      puertos, llaves RSA/Ed25519).  
    * Implementación de políticas de Firewall (IPtables/UFW) con enfoque  
      _deny-all_ por defecto.  
    * Optimización de Kernel: Ajustes de parámetros de red y seguridad vía  
	  `sysctl`.  
* Gestión de paquetes: limpieza de servicios innecesarios para reducir la  
  superficie de ataque.  
* Automatización con Python/Bash: guiones modulares para facilitar el  
  mantenimiento post-despliegue.  
      
> Advertencia: estos guiones modifican configuraciones críticas del sistema.  
> Se recomienda probar en entornos de staging antes de su ejecución en  
> producción.  

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
