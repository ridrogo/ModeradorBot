local triggers = {
	'^/test'
}

local function on_each_msg(msg, ln)
	return msg
end

local action = function(msg, blocks, ln)
if blocks[1] == 'isbanned' and blocks[2] then
      if is_blocked(blocks[2]) then
        api.sendReply(msg, '✅ Este usuario si esta globalmente banneado.')
      else
        api.sendReply(msg, '❌❗️Este usuario no esta globalmente banneado o se ha ingresado el alias en lugar del ID. Si quieres reportarlo puedes reportarlo por privado a @Webrom o @Webrom2. Gracias.')
      end
    end
end

return {
	action = action,
	triggers = triggers,
	test = true
}