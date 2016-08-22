local action = function(msg, matches)
  if matches[1] == '_' then
    api.sendMessage(msg.chat.id, '_' ..matches[2].. '_', true)
    end
  if matches[1] == '*' then   
      api.sendMessage(msg.chat.id, '*' ..matches[2].. '*', true)
  end
end

 return {
  action = action,
  triggers = {
               "(.*)(*)(.*)(*)(.*)",
               "(.*)(_)(.*)(_)(.*)"
   }
}