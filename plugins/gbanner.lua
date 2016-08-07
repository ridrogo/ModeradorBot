local action = function(msg, matches)

 		if not(msg.chat.type == 'private') and not is_mod(msg) then return end

if matches[1] == "gban" then
	if matches[2] then
		os.execute('echo "' ..matches[2].. '," >> ./data/gbans')
		api.sendReply(msg, "ID " ..matches[2].. " *globalmente baneado*.", true)
		bot_init(true)
 	end
 
 	if not matches[2] then
		if msg.reply then
			os.execute('echo "' ..msg.reply.from.id.. '," >> ./data/gbans')
			api.sendReply(msg, "ID " ..msg.reply.from.id.. " *globalmente baneado*.", true)
			bot_init(true)
		else
			api.sendMessage(msg.chat.id, "Este comando necesita respuesta")
		end
	end
end

if matches[1] == "ungban" then
	
 	if matches[2] then
		os.execute('sed -i "/' ..matches[2].. '/d" ./data/gbans')
		api.sendReply(msg, "ID " ..matches[2].. " *globalmente desbaneado*.", true)
		bot_init(true)
	end
	
	 if not matches[2] then
		if msg.reply then
			os.execute('sed -i "/' ..msg.reply.from.id.. '/d" ./data/gbans')
			api.sendReply(msg, "ID " ..msg.reply.from.id.. " *globalmente desbaneado*.", true)
			bot_init(true)
		else
			api.sendMessage(msg.chat.id, "Este comando necesita respuesta")
		end
 	 end
end

if matches[1] == "isban" then
		if not msg.reply then
			api.sendReply(msg, 'Este comando necesita una respuesta, el username o el Id para funcionar')
			return
		else
	 if not matches[2] then
		if msg.reply then
			os.execute('grep "' ..msg.reply.from.id.. '," >> ./data/gbans')
			api.sendReply(msg, "ID " ..msg.reply.from.id.. " *ID se encuentra en BD*.", true)
			bot_init(true)
		else
			os.execute('grep "' ..msg.reply.from.id.. '," >> ./data/gbans')
			api.sendReply(msg, "ID " ..msg.reply.from.id.. " *ID No se encuentra en BD*.", true)
			bot_init(true)
		 end
end

end
end
end

return {
	action = action,
	triggers = {
				'^/(gban)$',
				'^/(gban) (%d+)$',
				'^/(ungban)$',
				'^/(ungban) (%d+)$',
				'^/(isban)$'
				}
		}

