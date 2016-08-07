local action = function(msg, blocks, ln)
 	
 		if not (msg.chat.type == 'private') and not is_mod(msg) then return end
 		
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
			text = '\n' ..name.. ', el ID ' ..id.. ' ha sido Desbloqueado y Desbaneado Globalmente por @' ..bot.username.. ', si fue un error, disculpa las molestias, gracias. 🔰\n'							
--			text = id..' Has sido Desbloqueado y desbaneado Globalmente'
		else
			text = '\n' ..name.. ', el ID ' ..id.. ' ya has sido Desbloqueado y Desbaneado Globalmente por @' ..bot.username.. ', gracias. 🔰\n'
--			text = id..' Ya estás Desbloqueado y desbaneado Globalmente'
		end
		api.sendReply(msg, text)
	end
	if blocks[1] == 'isgban' then
		if not msg.reply then
			api.sendReply(msg, 'Este comando necesita una respuesta, o el ID para funcionar')
			return
		else
			if is_blocked_global(msg.reply.from.id) then
				api.sendReply(msg, 'yes')
			else
				api.sendReply(msg, 'no')
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
	}
}