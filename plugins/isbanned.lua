local action = function(msg, blocks)
	local id
	local response
	if blocks[1] == 'isbanned' then
		if not msg.reply then
			api.sendReply(msg, 'Este comando necesita una respuesta, el username o el Id para funcionar')
			return
			else
				id = msg.reply.from.id
			end
		else
			if is_blocked(msg.reply.from.id) then
				api.sendReply(msg, '✅ Este usuario si esta globalmente banneado.')
			else
				api.sendReply(msg, '❌❗️Este usuario no esta globalmente banneado o se ha ingresado el alias en lugar del ID. Si quieres reportarlo puedes reportarlo por privado a @Webrom o @Webrom2. Gracias.')
			end
		end
--if blocks[1] == 'isbanned' and blocks[2] then
--     if is_blocked(blocks[2]) then
--        api.sendReply(msg, '✅ Este usuario si esta globalmente banneado.')
--      else
--        api.sendReply(msg, '❌❗️Este usuario no esta globalmente banneado o se ha ingresado el alias en lugar del ID. Si quieres reportarlo puedes reportarlo por privado a @Webrom o @Webrom2. Gracias.')
--      end
--    end
end

return {
   action = action,
   triggers = {
'^/(isbanned) (%d*)$',
'^!(isbanned) (%d*)$'
	}
}
