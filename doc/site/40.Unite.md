Title: Registro
Author: ~ferorge
Date: 2024-02-13
copyright: 2024, ~ferorge, CC BY-SA 4.0.
Email: ferorge@texto-plano.xyz
KeyWords: tilde, publico, libre, pubnix, auto alojado, soberano
css: lynx.css

# Registro de nuevos usuaries

---
##### *Registro*

---

Si quieres ser usuarie de este pubnix puedes registrarte siguiendo los pasos detallados a continuación.  
Por favor lee la política de [seguridad][issue] antes de registrarte.  

[issue]:https://tilde.dynv6.net/seguridad.html

---
###### **Al registrarte en este pubnix, reconoces y aceptas la política de seguridad.**

---

1. Conéctate mediante *ssh* al usuario "*registro*" utilizando la contrasena "*Ahora!*", a través del puerto *30022*.  
`
$: ssh -p 30022 registro@tilde.dynv6.net
`
2. Luego completa la información solicitada en el formulario.  
Si todo ha salido bien obtendrás una contraseña provisoria para el primer inicio de sesión.  
**El unico campo obligatorio es el nombre de usuario, los restantes son opcionales y públicos.**  
**Indica solo los datos que puedan ser obtenidos por otros usuaries.**  
3. Repite el paso 1, pero esta vez utilizando el usuario que registraste y la contraseña provisoria obtenida en el paso anterior.  
Si todo ha salido bien concluiste el registro, ya eres usuarie de este pubnix.  
4. Repite el paso 1, pero esta vez utilizando el usuario que registraste y la contraseña definitiva registrada en el paso anterior.  

A continuacion hay un ejemplo de registro `remarcando` los valores a ingresar:  

---
  
### **Paso 1**
$: `ssh -p 30022 registro@tilde.dynv6.net`  
registro@tilde.dynv6.net's password:  
  
### **Paso 2**
Ingrese el nombre de usuario : `zumba`  
Ingrese el nombre real (opcional) : `Zumba PR`  
Ingrese el numero de habitacion (opcional) : `23`  
Ingrese el numero del trabajo (opcional) : `7`  
Ingrese el numero de su hogar (opcional) : `11`  
Ingrese su correo electronico (opcional) : `zumba@localhost`  
Hola!  
Tu peticion de registro fue realizada satisfactoriamente y sera procesada a la brevedad.  
Por favor escriba la contraasena temporal de abajo para iniciar sesion por primera vez:  

  
     ________
    ( 68a947 )
     --------
          o   ^__^
           o  (oo)\_______
              (__)\       )\/\
                  ||----w |
                  ||     ||
     _______________
    < Buena semana. >
     ---------------
           \   ^__^
            \  (oo)\_______
               (__)\       )\/\
                   ||----w |
                   ||     ||
   

Connection to tilde.dynv6.net closed.  
  
### **Paso 3**
$: `ssh -p 30022 zumba@tilde.dynv6.net`  
zumba@tilde.dynv6.net's password:  
You are required to change your password immediately (administrator enforced).  
WARNING: Your password has expired.  
You must change your password now and login again!  
Changing password for zumba.  
Current password:  
New password:  
Retype new password:  
passwd: password updated successfully  
Connection to tilde.dynv6.net closed.  
  
### **Paso 4**
$: `ssh -p 30022 zumba@tilde.dynv6.net`  
zumba@tilde.dynv6.net's password:  
  

---

###### Licencia

El contenido de este documento está bajo licencia [Creative Commons Attribution - Share Alike 4.0][CC BY-SA 4.0]
[CC BY-SA 4.0]:https://creativecommons.org/licenses/by-sa/4.0/deed.es

![Creative Commons Attribution - Share Alike 4.0](https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-sa.png "CC BY-SA 4.0" width=44px height=15px)

---
