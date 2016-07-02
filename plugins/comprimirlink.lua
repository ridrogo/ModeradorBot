 local action = function(msg, matches, ln)
	api.sendMessage(msg.chat.id, make_text '*Link comprimido.*\n\n¡Hola! Te invito a ingresar a este [link](' ..matches[1].. ')\n\n_Reenvialo para que tus amigos lo vean._', true)
	mystat('/comprimir') --save stats
end

return {
	action = action,
	triggers = {
		'^/[Cc]omprimir (.*)$'
	}
}
