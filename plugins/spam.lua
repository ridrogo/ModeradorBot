local action = function(msg, blocks, ln)

	if (msg.chat.type == 'private') and not is_mod(msg) then return end

	local text

if blocks[1] == 'antispam' then
		if blocks[2]:match('^(on)$') and blocks[2]:match('^(off)$') then
			api.sendMessage(msg.chat.id, 'Estados disponibles: on/off')
			return
		end
		local status = blocks[2]
		local current = db:hget('chat:'..msg.chat.id..':settings', 'antispam')
		if current == status then
			api.sendMessage(msg.chat.id, 'Modo Anti-Spam *ya está '..status..'*', true)
		else 
			db:hset('chat:'..msg.chat.id..':settings', 'antispam', status)
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
