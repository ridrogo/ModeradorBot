local action = function(msg, blocks, ln)
 	
	if not(msg.chat.type == 'private') and not is_owner(msg) then return end
	
if blocks[1] == "gban" then
			local id
			local name
		if not blocks[2] then
			if not msg.reply then
				api.sendReply(msg, 'Este comando necesita una respuesta, o el Id para funcionar')
				return
			else
			id = msg.reply.from.id
			name = msg.from.first_name
    		if msg.from.username then name = name..' (@'..msg.from.username..')' end
			end
		else
		id = blocks[2]
		name = msg.from.first_name
    	if msg.from.username then name = name..' (@'..msg.from.username..')' end
		end
		if msg.reply then
			os.execute('echo "' ..id.. '," >> ./data/gbans')
			bot_init(true)
		end
		if blocks[2] then
		os.execute('echo "' ..blocks[2].. '," >> ./data/gbans')
		bot_init(true)
		end
		local response = db:sadd('bot:blocked', id)
		local text
		if response == 1 then
			text = '\n' ..name.. ', el ID ' ..id.. ' ha sido Bloqueado y Baneado Globalmente por @' ..bot.username.. ', si crees que es un error, contacta a @Webrom o @Webrom2 para que pueda revisar tu caso, gracias. 🔰\n'				
--			text = id..' Has sido Bloqueado y expulsado Globalmente'
		 else			
			text = '\n' ..name.. ', el ID ' ..id.. ' ya ha sido Bloqueado y Baneado Globalmente por @' ..bot.username.. ', si crees que es un error, contacta a @Webrom o @Webrom2 para que pueda revisar tu caso, gracias. 🔰\n'
--			text = id..' Ya estás Bloqueado y expulsado Globalmente'
		end
		api.sendReply(msg, text)
	end

	if blocks[1] == 'ungban' then
			local id
			local name
		if not blocks[2] then
			if not msg.reply then
				api.sendReply(msg, 'Este comando necesita una respuesta, o el Id para funcionar')
				return
			else
			id = msg.reply.from.id
			name = msg.from.first_name
    		if msg.from.username then name = name..' (@'..msg.from.username..')' end
			end
		else
		id = blocks[2]
		name = msg.from.first_name
    	if msg.from.username then name = name..' (@'..msg.from.username..')' end
		end
		if msg.reply then
			os.execute('sed -i "/' ..id.. '/d" ./data/gbans')
			bot_init(true)
		end
		if blocks[2] then
			os.execute('sed -i "/' ..blocks[2].. '/d" ./data/gbans')
			bot_init(true)
		end
		local response = db:srem('bot:blocked', id)
		local text
		if response == 1 then
			make_text = '\n' ..name.. ', el ID ' ..id.. ' ha sido Desbloqueado y Desbaneado Globalmente por (@' ..bot.username.. '), si fue un error, disculpa las molestias, gracias. 🔰\n'							
--			text = id..' Has sido Desbloqueado y desbaneado Globalmente'
		else
			make_text = '\n' ..name.. ', el ID ' ..id.. ' ya ha sido Desbloqueado y Desbaneado Globalmente por (@' ..bot.username.. '), gracias. 🔰\n'
--			text = id..' Ya estás Desbloqueado y desbaneado Globalmente'
		end
		api.sendReply(msg, make_text)
	end

	if blocks[1] == "isgban" then
	if blocks[2] then
		local grep = io.popen("grep -o "..blocks[2].. " ./data/gbans")
		local list = grep:read("*a")
		if list == "" then
		api.sendMessage(msg.chat.id, "_Esta ID no esta globalmente baneada_", true)
		else
			api.sendReply(msg, "La ID "..blocks[2].." está *globalmente baneada*", true)
--			api.sendMessage(msg.chat.id, "*Demasiado seguro*\nSe encontraron las siguientes coincidencias:\n\n_"..list.."_", true)
			end
	end
	
 	if not blocks[2] then
		if msg.reply then
			local grep = io.popen("grep "..msg.reply.from.id.. " ./data/gbans")
		local list = grep:read("*a")
		if list == "" then
		api.sendReply(msg, "_Esta ID no esta globalmente baneada_", true)
		else
	        api.sendReply(msg, "La ID "..msg.reply.from.id.." está *globalmente baneada*", true)
		end
		end
		end
end
end

return {
   action = action,
   triggers = {
	'^/(gban) (%d+)$',
	'^/(gban)$',
	'^/(ungban) (%d+)$',
	'^/(ungban)$',
	'^/(isgban)$',
	'^/(isgban) (%d+)$'
	}
}