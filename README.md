# ModeradorBot beta
Bot de Telegram para Administrar grupos, tipo Group Butler
ModeradorBot código beta
-------------------------
Bot de telegram usando API.

Más información en la [API de Telegram](https://core.telegram.org/bots/api).


Clonar repositorio:

```bash
# Clonar ModeradorBot
git clone https://github.com/ridrogo/ModeradorBot.git
```
```bash
# Mover a directorio y cambiar permisos de arranque
cd ModeradorBot && chmod +x launch.sh
```
Instalar ModeradorBot Beta: 

```bash
./install.sh
```

Opciones de launch.sh (en TMUX):

```bash
# Iniciar una sesión tmux
./launch.sh

# Detener la sesiones (script de lectura de gbans, y script del bot. Tmux)
./launch.sh kill

# Attach del bot (regresar a la sesión del bot. Tmux)
./launch.sh attach

# Attach de los gbans (regresar a la sesión de los gbans. Tmux)
./launch.sh attach-gbans

# Configurar y/o crear de nuevo el config.lua
./launch.sh config

```



Envia tus pullrequest para mejorar el código.



Contacta conmigo en TG
--------------------
[![https://telegram.me/Webrom](https://img.shields.io/badge/Webrom-Telegram-blue.svg)](https://telegram.me/Webrom)
