sis = require('posix')
HTTP = require('socket.http')
HTTPS = require('ssl.https')
URL = require('socket.url')
JSON = require('dkjson')
redis = require('redis')
clr = require 'term.colors'
db = Redis.connect('127.0.0.1', 6379)
--db:select(0)
serpent = require('serpent')
existe_apikey = io.open("./data/key","r")


bot_init = function(on_reload) -- The function run when the bot is started or reloaded.
--	print(clr.blue..'Loading config.lua...')
--	config = dofile('config.lua') -- Load configuration file.
--	if config.bot_api_key == '' then
--		print(clr.red..'API KEY MISSING!')
--		return
--	end
--	print('Loading utilities.lua...')
--	cross, rdb = dofile('utilities.lua') -- Load miscellaneous and cross-plugin functions.
--	print('Loading languages.lua...')
--	lang = dofile(config.languages) -- All the languages available
--	print('Loading API functions table...')
--	api = require('methods')
	
	print(clr.blue..'Deteniendo proceso de gbans...' ..clr.reset)
	os.execute('sudo tmux kill-session -t ScriptGban')
	print(clr.blue..'Leyendo config.lua...' ..clr.reset)
	config = dofile('config.lua') 
	if not existe_apikey then
		print(clr.red..'No hay api key' ..clr.reset)
		return
	end
	print(clr.blue..'Loading utilidades.lua...' ..clr.reset)
	cross, rdb = dofile('utilities.lua') 
	print(clr.blue..'Leyendo lenguages.lua...' ..clr.reset)
	lang = dofile(config.languages) 
	print(clr.blue..'Iniciando un nuevo proceso de gbans...' ..clr.reset)
	os.execute('sudo TMUX= tmux new-session -s "ScriptGban" -d "bash gbanner/metodo.sh gbans"')
	print(clr.blue..'Leyendo tabla de funciones...' ..clr.reset)
	api = require('methods')
	
	current_m = 0
	last_m = 0
	
	bot = nil
	while not bot do -- Get bot info and retry if unable to connect.
		bot = api.getMe()
	end
	bot = bot.result

	plugins = {} -- Load plugins.
	
		if config.bot_settings.plugins_esenciales then
		for i,v in ipairs(config.plugins_esenciales) do
			local p = dofile('plugins/'..v)
			print(clr.red..'Leyendo plugin...'..clr.reset, v)
			table.insert(plugins, p)
		end
	end
	
	if config.bot_settings.plugins_opcionales then
		for i,v in ipairs(config.plugins_opcionales) do
			local p = dofile('plugins/'..v)
			print(clr.red..'Leyendo plugin...'..clr.reset, v)
			table.insert(plugins, p)
		end
	end
	
	if config.bot_settings.plugins_test then
		for i,v in ipairs(config.plugins_test) do
			local p = dofile('plugins/'..v)
			print(clr.red..'Leyendo plugin...'..clr.reset, v)
			table.insert(plugins, p)
		end
	end
	
--	print('Loading plugins...')
--	for i,v in ipairs(config.plugins) do
--		local p = dofile('plugins/'..v)
--		print(clr.red..'Leyendo plugin...'..clr.reset, v)
--		table.insert(plugins, p)
--	end
--	print(clr.red..'Plugins loaded:', #plugins)
	
	if config.bot_settings.multipurpose_mode then
		for i,v in ipairs(config.multipurpose_plugins) do
			local p = dofile('plugins/multipurpose/'..v)
			table.insert(plugins, p)
		end
	end
	
	print('\n'..clr.blue..'BOT INICIADO:'..clr.reset, clr.red..'[@'..bot.username .. '] [' .. bot.first_name ..'] ['..bot.id..']'..clr.reset..'\n')
	if not on_reload then
		db:hincrby('bot:general', 'starts', 1)
		api.sendAdmin('*Bot iniciado*\n'..os.date('Día %A, %d %B %Y\nHora %X')..'\n'..#plugins..' plugins leídos', true)
	end
	
	-- Generate a random seed and "pop" the first random number. :)
	math.randomseed(os.time())
	math.random()

	last_update = last_update or 0 -- Set loop variables: Update offset,
	last_cron = last_cron or os.time() -- the time of the last cron job,
	is_started = true -- whether the bot should be running or not.

end

local function get_from(msg)
	local user = '['..msg.from.first_name
	if msg.from.last_name then
		user = user..' '..msg.from.last_name
	end
	user = user..']'
	if msg.from.username then
		user = user..' [@'..msg.from.username..']'
	end
	user = user..' ['..msg.from.id..']'
	return user
end

local function get_what(msg)
	if msg.sticker then
		return 'sticker'
	elseif msg.photo then
		return 'photo'
	elseif msg.document then
		return 'document'
	elseif msg.audio then
		return 'audio'
	elseif msg.video then
		return 'video'
	elseif msg.voice then
		return 'voice'
	elseif msg.contact then
		return 'contact'
	elseif msg.location then
		return 'location'
	elseif msg.text then
		return 'text'
	else
		return 'service message'
	end
end

local function collect_stats(msg)
	
	--count the number of messages
	db:hincrby('bot:general', 'messages', 1)
	
	--for resolve username
	if msg.from and msg.from.username then
		db:hset('bot:usernames', '@'..msg.from.username:lower(), msg.from.id)
		db:hset('bot:usernames:'..msg.chat.id, '@'..msg.from.username:lower(), msg.from.id)
	end
	if msg.forward_from and msg.forward_from.username then
		db:hset('bot:usernames', '@'..msg.forward_from.username:lower(), msg.forward_from.id)
		db:hset('bot:usernames:'..msg.chat.id, '@'..msg.forward_from.username:lower(), msg.forward_from.id)
	end
	
	if not(msg.chat.type == 'private') then
		if msg.from and msg.from.id then
			db:hset('chat:'..msg.chat.id..':userlast', msg.from.id, os.time()) --last message for each user
		end
	end
	
	--user stats
	if msg.from then
		db:hincrby('user:'..msg.from.id, 'msgs', 1)
	end
end

local function match_pattern(pattern, text)
  	if text then
  		text = text:gsub('@'..bot.username, '')
    	local matches = {}
    	matches = { string.match(text, pattern) }
    	if next(matches) then
    		return matches
		end
  	end
end

on_msg_receive = function(msg) -- The fn run whenever a message is received.
	--vardump(msg)
	if not msg then
		api.sendAdmin('A loop without msg!')
		return
	end
	
	if msg.date < os.time() - 5 then return end -- Do not process old messages.
	if not msg.text then msg.text = msg.caption or '' end
	
	msg.normal_group = false
	if msg.chat.type == 'group' then msg.normal_group = true end
	
	--for commands link
	--[[if msg.text:match('^/start .+') then
		msg.text = '/' .. msg.text:input()
	end]]
	
	--Group language
	msg.lang = db:get('lang:'..msg.chat.id)
	if not msg.lang then
		msg.lang = 'es'
	end
	
	collect_stats(msg) --resolve_username support, chat stats
	
	for i,plugin in pairs(plugins) do
		local stop_loop
		if plugin.on_each_msg then
			msg, stop_loop = plugin.on_each_msg(msg, msg.lang)
		end
		if stop_loop then --check if on_each_msg said to stop the triggers loop
			break
		else
			if plugin.triggers then
				if (config.testing_mode and plugin.test) or not plugin.test then --run test plugins only if test mode it's on
					for k,w in pairs(plugin.triggers) do
						local blocks = match_pattern(w, msg.text)
						if blocks then
							
							--workaround for the stupid bug
							if not(msg.chat.type == 'private') and not db:exists('chat:'..msg.chat.id..':settings') and not msg.service then
								cross.initGroup(msg.chat.id)
							end
							
							--print in the terminal
							print(clr.reset..clr.blue..'['..os.date('%X')..']'..clr.red..' '..w..clr.reset..' '..get_from(msg)..' -> ['..msg.chat.id..'] ['..msg.chat.type..']')
							
							--print the match
							if blocks[1] ~= '' then
      							db:hincrby('bot:general', 'query', 1)
      							if msg.from then db:incrby('user:'..msg.from.id..':query', 1) end
      						end
							
							--execute the plugin
							local success, result = pcall(function()
								return plugin.action(msg, blocks, msg.lang)
							end)
							
							--if bugs
							if not success then
								print(msg.text, result)
							--	api.sendReply(msg, '*This is a bug!*\nPlease report the problem with `"/c"` command :)', true)
								save_log('errors', result, msg.from.id or false, msg.chat.id or false, msg.text or false)
          						api.sendAdmin('An #error occurred.\n'..result..'\n'..msg.lang..'\n'..msg.text)
								return
							end
							
							-- If the action returns a table, make that table msg.
							if type(result) == 'table' then
								msg = result
							elseif type(result) == 'string' then
								msg.text = result
							-- If the action returns true, don't stop.
							elseif result ~= true then
								return
							end
						end
					end
				end
			end
		end
	end
end

local function service_to_message(msg)
	msg.service = true
	if msg.new_chat_member then
    	if tonumber(msg.new_chat_member.id) == tonumber(bot.id) then
			msg.text = '###botadded'
		else
			msg.text = '###added'
		end
		msg.adder = clone_table(msg.from)
		msg.added = clone_table(msg.new_chat_member)
	elseif msg.left_chat_member then
    	if tonumber(msg.left_chat_member.id) == tonumber(bot.id) then
			msg.text = '###botremoved'
		else
			msg.text = '###removed'
		end
		msg.remover = clone_table(msg.from)
		msg.removed = clone_table(msg.left_chat_member)
	elseif msg.group_chat_created then
    	msg.chat_created = true
    	msg.adder = clone_table(msg.from)
    	msg.text = '###botadded'
	end
    return on_msg_receive(msg)
end

local function forward_to_msg(msg)
	if msg.text then
		msg.text = '###forward:'..msg.text
	else
		msg.text = '###forward'
	end
    return on_msg_receive(msg)
end

local function media_to_msg(msg)
	if msg.photo then
		msg.text = '###image'
		--if msg.caption then
			--msg.text = msg.text..':'..msg.caption
		--end
	elseif msg.video then
		msg.text = '###video'
	elseif msg.audio then
		msg.text = '###audio'
	elseif msg.voice then
		msg.text = '###voice'
	elseif msg.document then
		msg.text = '###file'
		if msg.document.mime_type == 'video/mp4' then
			msg.text = '###gif'
		end
	elseif msg.sticker then
		msg.text = '###sticker'
	elseif msg.contact then
		msg.text = '###contact'
	end
	msg.media = true
	
	if msg.entities then
		for i,entity in pairs(msg.entities) do
			if entity.type == 'url' then
				msg.url = true
				msg.media = true
				break
			end
		end
		if not msg.url then msg.media = false end --if the entity it's not an url (username/bot command), set msg.media as false
	end
	
--[[	--cehck entities for links/text mentions
	if msg.entities then
		for i,entity in pairs(msg.entities) do
			if entity.type == 'text_mention' then
				msg.mention_id = entity.user.id
			end
			if entity.type == 'url' or entity.type == 'text_link' then
				if msg.text:match('[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm]%.[Mm][Ee]') then
					msg.media_type = 'TGlink'
				else
					msg.media_type = 'link'
				end
				msg.media = true
			end
		end
	end]]

	if msg.reply_to_message then
		msg.reply = msg.reply_to_message
	end
	
	return on_msg_receive(msg)
end

local function rethink_reply(msg)
	msg.reply = msg.reply_to_message
	if msg.reply.caption then
		msg.reply.text = msg.reply.caption
	end
	return on_msg_receive(msg)
end

local function handle_inline_keyboards_cb(msg)
	msg.text = '###cb:'..msg.data
	msg.old_text = msg.message.text
	msg.old_date = msg.message.date
	msg.date = os.time()
	msg.cb = true
	msg.cb_id = msg.id
	--msg.cb_table = JSON.decode(msg.data)
	msg.message_id = msg.message.message_id
	msg.chat = msg.message.chat
	msg.message = nil
	msg.target_id = msg.data:match('.*:(-?%d+)')
	return on_msg_receive(msg)
end

---------WHEN THE BOT IS STARTED FROM THE TERMINAL, THIS IS THE FIRST FUNCTION HE FOUNDS

bot_init() -- Actually start the script. Run the bot_init function.

--while is_started do -- Start a loop while the bot should be running.
repeat -- reemplazado el while loop por repeat, en test múltiples parece ofrecer mejor respuesta y tolerancia a errores.
    local res = api.getUpdates(last_update+1) -- Get the latest updates!
    if not res or res.ok == false then
        print('Connection error')     
        bot_init(true)
    else
--        vardump(res)
        clocktime_last_update = os.clock()
        real_time = os.time()
        if not res.result then -- evita un boleano al no resolver correctamente la tabla msg
            resultado = nil
        else
            resultado = res.result 
        end
        for i=1, #resultado do 
            last_update = resultado[i].update_id
            current_m = current_m + 1
            local msg
            msg = resultado[i]
            if msg.inline_query then -- mensajes inline
                handle_inline_query(msg.inline_query)
            end
            if msg.edited_message then -- mensajes editados
			    msg.message = msg.edited_message 
				msg.message.original_date = msg.edited_message.date
				msg.message.date = msg.edited_message.edit_date
--				msg.message.entities = nil
		    end
		    if msg.callback_query then
                handle_inline_keyboards_cb(msg.callback_query)
            end
            if msg.message then
            if not msg.message.text then --evita un error boleano al no encontrar un msg.text en tabla msg 
                trigger = nil
            else
                trigger = msg.message.text:match('^[/!#]([^%s]+)$')
            end
            if trigger and (msg.message.date <= os.time() - 5) then -- si es un comando del bot y el tiempo de la api es distinto al del server por mucho, no procesará el mensaje (app son 5 segundos) 
--                if not is_dev(msg.message) then  -- bloqueara a esos usuarios flooders para el uso del bot
--                    db:sadd('bot:blocked', msg.message.from.id)
--                end
            print('Flood de comandos, no se procesarán los mensajes')
--            elseif msg.message.date <= os.time(os.date("!*t")) - 7 then -- si los mensjaes son muy antiguos no los procesará el bot
--            print('Tiempo de mensajes demasiado antiguo, no se procesaran los mensajes')
        else
--     		if msg.channel_post then -- si el mensaje procesado viene de un canal
--    		    msg.channel_post.channel_post = true
--			elseif msg.edited_channel_post then
--				msg.edited_channel_post.edited_channel_post = true
--				msg.edited_channel_post.original_date = msg.edited_channel_post.date
--				msg.edited_channel_post.date = msg.edited_channel_post.edit_date
--			end
                if msg.message.migrate_to_chat_id then
                    to_supergroup(msg.message)
                elseif msg.message.new_chat_member or msg.message.left_chat_member or msg.message.group_chat_created or msg.message.new_chat_title or msg.message.pinned_message then
                    service_to_message(msg.message)
                elseif msg.message.photo or msg.message.video or msg.message.document or msg.message.voice or msg.message.audio or msg.message.sticker or msg.message.game or msg.message.entities or msg.message.caption then
                    media_to_msg(msg.message)
                elseif msg.message.forward_from or msg.message.forward_from_chat then
                    forward_to_msg(msg.message)
                elseif msg.message.reply_to_message then
                    rethink_reply(msg.message)
                else
                    on_msg_receive(msg.message)
                end
               end
            end
        end
  end
    if last_cron ~= os.date('%M') then -- Run cron jobs every hour.
        last_cron = os.date('%M')
        last_m = current_m
        current_m = 0
     local pid = sis.fork()
	 if (pid<0) then
	 	print('error en fork')
	 	api.sendAdmin('Error en fork funcion clean')
	 elseif (pid==0) then 
	    for i=1, #plugins do
			if plugins[i].cron then -- Call each plugin's cron function, if it has one.
				local res2, err = pcall(plugins[i].cron)
				if not res2 then
					api.sendLog('An #error occurred (cron).\n'..err)
					return
                end
            end
      end
	  sis._exit(0)
	end        
end
until false

print('Halted.')
