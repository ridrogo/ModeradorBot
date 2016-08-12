local action = function(msg, blocks, ln)

if not (msg.chat.type == 'private') and is_mod(msg) then 

 if blocks[1] == 'groseria' then
		if not blocks[2]:match('^(enable)$') and not blocks[2]:match('^(disable)$') then
			api.sendReply(msg, '*ERROR*\nDebe usarse de esta manera:\n`/groseria enable|disable`', true)
			return
		end
		local status = blocks[2]
		local current = db:hget('chat:'..msg.chat.id..':settings', 'groseria')
		if current == status then
			grep = status:gsub('^enable$', 'permitida'):gsub('^disable$', 'prohibida')
			api.sendMessage(msg.chat.id, 'Los groseria ya estaba *'..grep..'*', true)		
		else
			db:hset('chat:'..msg.chat.id..':settings', 'groseria', status)
			grep = status:gsub('^enable$', 'permitida'):gsub('^disable$', 'prohibida')
			api.sendMessage(msg.chat.id, 'Ahora la groseria estará *'..grep..'*', true)
		end
	end
  end
end

return {
	action = action,
	triggers = {
	'^/(groseria) (%a+)$',
	}
}
