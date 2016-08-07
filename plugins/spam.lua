local action = function(msg, blocks, ln)

 			local is_normal_group = false
	   		if msg.chat.type == 'group' then is_normal_group = true end
	
	local text
if blocks[1] == 'antispam' then
		if blocks[2]:match('^(on)$') and blocks[2]:match('^(off)$') then
			api.sendMessage(msg.chat.id, 'Estados disponibles: on/off')
			return
		end
		local status = blocks[2]
		local current = db:hget('bot:general', 'antispam')
		if current == status then
			api.sendMessage(msg.chat.id, 'Modo Anti-Spam *ya está '..status..'*', true)
		else 
			db:hset('bot:general', 'antispam', status)
			api.sendMessage(msg.chat.id, 'Modo Anti-Spam: *'..status..'*', true)
		end
	end

end

return {
	action = action,
	triggers = {
	'^/(antispam) (%a%a%a?)$',
	}
}
