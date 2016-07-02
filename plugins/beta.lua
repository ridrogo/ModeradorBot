local triggers = {
	'^/(beta)$'
}

local action = function(msg, blocks, ln)

if blocks[1] == 'beta' then
	username = msg.from.username
    	api.sendDocument(msg.from.id, './org.telegram.plus-3.10.1.0.apk')
    	api.sendMessage(msg.chat.id, 'Te enviaré la versión beta última de Plus Messenger en un minuto por privado.\n*Verifica el privado del bot* :)\n\nBeta enviada a: @' ..username, true)
    end
    end
    
 return {
	action = action,
	triggers = triggers
}
