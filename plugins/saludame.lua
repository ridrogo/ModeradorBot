local triggers = {
		'^/(saluda) (.*)$'
		}


local action = function(msg, matches, ln)

if matches[1] == 'saluda' then

	api.sendMessage(msg.chat.id, '' ..matches[2].. '', true)
	end
	end


 return {
   action = action,
   triggers = triggers
   }
