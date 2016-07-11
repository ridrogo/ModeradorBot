local action = function(msg, blocks)
if blocks[1] == 'a' then
api.sendReply(msg, make_text '*ERROR*\n`Debes ingresar un texto despúes del comando`.', true)
end
end

return {
     action = action,
     triggers = {
         '^/caracolamagic(a)$',
         '^/caracol(a)$',
         '^/ser(a)$'
}
}
