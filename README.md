ModeradorBot
-------------------------
Bot de telegram usando API conexiones.

Más información en la [API de Telegram](https://core.telegram.org/bots/api).


Clonar repositorio:

```bash
# Clonar ModeradorBot
git clone https://github.com/ridrogo/ModeradorBot.git
```
```bash
# Mover a directorio y cambiar permisos de arranque
cd ModeradorBot && chmod +x run.sh
```
Instalar ModeradorBot: 

```bash
./run.sh install
```

Al terminar la instalación te pedirá el apikey del bot, la ID Owner del Apikey del bot, tu ID en telegram o la ID de tu admin1, la ID de tu admin2 y tu canal, por favor, ingresalos y pulsa enter. (si no tienes un admin2 o canal puedes dejar esos valores en blanco con enter)

Despúes, el bot ya estará funcionando si lo haz configurado bien, cualquier falla vuelvelo a configurar.


**IMPORTANTE**    
_Al iniciar ./run.sh config o al volver iniciar el instalador, config.lua será eliminado y reemplazado por el de origen, para evitar cualquier error propio, si ya haz personalizado el config.lua renombra o copia tu config.lua_.



Más funciones del bash run.sh (en screen):

```bash
# Volver a iniciar una sesión normal
./run.sh

# Arrancar ModeradorBot en screen, siempre arrancando
./run.sh kp

# Detener última sesión de ModeradorBot en screen
./run.sh kill

# Borrar logs por consola
./run.sh rmlogs

# Configurar y/o crear de nuevo el config.lua
./run.sh config

```

Opciones de run2.sh (en TMUX):

```bash
# Iniciar una sesión tmux
./run.sh

# Detener la sesiones (script de lectura de gbans, y script del bot. Tmux)
./run.sh kill

# Attach del bot (regresar a la sesión del bot. Tmux)
./run.sh attach

# Attach de los gbans (regresar a la sesión de los gbans. Tmux)
./run.sh attach-gbans

# Configurar y/o crear de nuevo el config.lua
./run.sh config

```



Envia tus pullrequest para mejorar el código.



Contacta conmigo en TG
--------------------
[![https://telegram.me/Webrom](https://img.shields.io/badge/Webrom-Telegram-blue.svg)](https://telegram.me/Webrom)
