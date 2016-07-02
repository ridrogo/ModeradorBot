local triggers = {
		'^/send (imagen) (.*)$',
		'^/send (sticker) (.*)$',
		'^/send (archivo) (.*)$',
		'^/send (gif) (.*)$',
		'^/send (video) (.*)$',
		'^/send (formatos)$',
		}

local action = function(msg, blocks)
	--blocks de imagenes
 if blocks[1] == 'imagen' then
 	imagen = blocks[2]
	api.sendPhoto(msg.chat.id, './enviar/imagen/' ..imagen.. '.jpg')
	api.sendPhoto(msg.chat.id, './enviar/imagen/' ..imagen.. '.jpeg')
	api.sendPhoto(msg.chat.id, './enviar/imagen/' ..imagen.. '.png')
	api.sendPhoto(msg.chat.id, './enviar/imagen/' ..imagen.. '.tiff')
	api.sendPhoto(msg.chat.id, './enviar/imagen/' ..imagen.. '.psd')
	end
	
	--blocks de stickers	
 if blocks[1] == 'sticker' then
    sticker = blocks[2]
    api.sendSticker(msg.chat.id, './enviar/sticker/' ..sticker.. '.webp')
  end
  
    -- blocks de archivos
 if blocks[1] == 'archivo' then
    archivo = blocks[2]
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.jpg')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.psd')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.swf')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.jpeg')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.zip')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.rar')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.lua')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.png')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.webp')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.tar')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.gz')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.tar.gz')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.sh')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.img')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.lnk')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.gif')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.rdb')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.exe')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.mp3')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.wma')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.aac')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.flac')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.mp4')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.webm')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.wmv')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.apk')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.ipa')
    api.sendDocument(msg.chat.id, './enviar/archivo/' ..archivo.. '.avi')
  end
  
  	--blocks de gif
 if blocks[1] == 'gif' then
 	gif = blocks[2]
 	api.sendVideo(msg.chat.id, './enviar/gif/' ..gif.. '.gif')
 	api.sendVideo(msg.chat.id, './enviar/gif/' ..gif.. '.mp4')
 	end
 	
 	-- blocks de video
 if blocks[1] == 'video' then
 	video = blocks[2]
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.mp4')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.webm')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.mov')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.wmv')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.dvd')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.avi')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.mkv')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.3gp')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.3g2')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.m4v')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.m4p')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.divx')
 	api.sendVideo(msg.chat.id, './enviar/video/' ..video.. '.wmv')
 	end
 	
 	-- Blocks de formatos
 if blocks[1] == 'formatos' then
 	api.sendReply(msg, make_text '_Si enviaste este mensaje en un grupo, el bot te enviará los formatos compatibles solamente por PV_\n\n_Si no haz iniciado el bot primero inicialo_.\nIniciame [aquí](http://telegram.me/Moderadores_Bot)', true)
 	-- Responde con los formatos disponibles al PV
 	api.sendMessage(msg.from.id, make_text '*Haz solicitado los formatos disponibles*.\n\n_Formatos de archivos_\n- jpg\n- jpeg\n- png\n- psd\n- swf\n- tar\n- tar.gz\n- gz\n- zip\n- rar\n- lua\n- webp\n- sh\n- img\n- lnk\n- gif\n- rdb\n- exe\n- mp3\n- wma\n- aac\n- flac\n- mp4\n- webm\n- wmv\n- apk\n- ipa\n- avi\n\n_Formatos de video_\n- mp4\n- webm\n- mov\n- mwv\n- dvd\n- avi\n- mkv\n- 3gp\n- 3g2\n- m4v\n- m4p\n- divx\n- wmv\n\n_Formatos de imagen_\n- jpeg\n- jpg\n- png\n- tiff\n- psd\n\n_Formatos de stickers_\n- webp\n\n_Formatos de gif_\n- gif\n- mp4 ', true)
end -- cierre de blocks
end -- cierre de script completo
 return {
 	triggers = triggers,
 	action = action
 	}
