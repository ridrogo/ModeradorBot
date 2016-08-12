local action = function(msg, blocks)
	
	if blocks[1] == 'isbanned' then
		if not blocks[2] then
		if not msg.reply then
			api.sendReply(msg, '🔰Respondele a alguien para saber si está globalmente baneado (en grupos) y te enviaré el resultado por privado o consulta por privado adjuntando la ID: /isbanned (ID) por ejemplo: /isbanned 123456789')
			return
		else
			id = msg.reply.from.id
			end
		else
			id = blocks[2]
		end
		if msg.reply then
		local grep = io.popen("grep "..id.. " ./data/gbans")
		local list = grep:read("*a")
		end
		if blocks[2] then
		local grep = io.popen("grep -o "..blocks[2].. " ./data/gbans")
		local list = grep:read("*a")
		end
		if is_blocked_global(id) or list == "" then
        api.sendMessage(msg.from.id, '✅ Este usuario si esta globalmente banneado.')
      else
        api.sendMessage(msg.from.id, '❌❗️Este usuario no esta globalmente banneado. Si quieres reportarlo puedes hacerlo por privado a @Webrom o @Webrom2. Gracias.')
      end
    end

end

return {
   action = action,
   triggers = {
'^/(isbanned)$',
'^/(isbanned) (%d+)$'
	}
}

