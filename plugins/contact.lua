local triggers = {
		'^/(mensaje) (.*) (.*)$',
		'^/(responder) (.*)'
		}

local action = function(msg, blocks)
 --if msg.from.id == config.admin or mag.from.id == config.support then
-- return
-- end
 if blocks[1] == 'mensaje' then
    idto = blocks[3]
    message = blocks[2]
    nameowner = msg.from.first_name
	api.sendMessage(idto, message.. '\n\nEnviado por: ' ..nameowner.. '\n_Contesta con /responder [respuesta]_', true)
	api.sendMessage(msg.chat.id, '¡Mensaje enviado!')
end
 if blocks[1] == 'responder' then  
 	iduser = msg.from.id
  name = msg.from.first_name
  user = msg.from.username
 	message = blocks[2]
 	api.sendMessage(config.admin, make_text'' ..message.. '\n\n_ID Del Usuario_: ' ..iduser.. '\n_Nombre_: ' ..name.. '\n_Usuario_: @' ..user, true)
 	api.sendMessage(config.support, make_text'' ..message.. '\n\n_ID Del Usuario_: ' ..iduser.. '\n_Nombre_: ' ..name.. '\n_Usuario_: @' ..user, true)
 	api.sendMessage(msg.chat.id, '¡Respuesta enviada!')
 	end
-- if blocks[1] == 'duda' or blocks[1] == 'ayuda' or blocks[1] == 'soporte' then
--    api.sendMessage(config.support, message.. '\n\n_ID Del Usuario:_ ' ..iduser, true)
-- 	api.sendMessage(msg.chat.id, '¡Respuesta enviada al equipo de soporte!')
-- end
 end
 
 return {
 	triggers = triggers,
 	action = action
 	}
