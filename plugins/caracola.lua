local action = function(msg, blocks, ln)
	
if blocks[1] == 'caracolamagica' or blocks[1] == 'caracola' and blocks[2] then
math.randomseed(os.time());
end
  num = math.random(0,3);
  if num == 0 then
	api.sendSticker(msg.chat.id,  './caracola/si.webp')
  elseif num == 1 then
  api.sendSticker(msg.chat.id, './caracola/no.webp')
 elseif num == 2 then
	api.sendSticker(msg.chat.id,  './caracola/probablemente.webp')
  elseif num == 3 then
	api.sendSticker(msg.chat.id,  './caracola/nocreo.webp')
       end
    end
  
    
 return {
 	action = action,
 	triggers = {
 	'/[Cc]aracolamagica (.*)',
	'/[Cc]aracola (.*)'
 		}
 	}
