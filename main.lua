function love.load()
         require("socket")

         require("img")
         require("class/_pecera")
         require("class/_pez")

         math.randomseed(socket.gettime()*10000)

         SCREEN_W = love.window.getWidth()
         SCREEN_H = love.window.getHeight()

         loadImgs()

         RELOJ_LIMITE = 1  -- Segundos
         RELOJ = RELOJ_LIMITE
         PECERA = Pecera.create()
         PECERA:Empezar()
         
         DRAWBBOX = false
end

function love.update(dt)
         RELOJ = RELOJ + dt

         PECERA:Update(dt)

         if RELOJ >= RELOJ_LIMITE then
            PECERA:IA()
            RELOJ = 0
         end
end

function love.draw()
         PECERA:Draw(DRAWBBOX)
         love.graphics.print("Para reiniciar, pulsar r.", 15, 15)
end

function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
         if key == 'r' then
            PECERA:Empezar()
         end
end

function love.keyreleased(key, unicode)
end

function love.focus(f)
end

function love.quit()
end


-- UTILS --

function insideBox (px, py, x, y, wx, wy)
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end

function getDistance( x1, y1, x2, y2 )
   xDiff = x2 - x1
   yDiff = y2 - y1
   return math.sqrt( (xDiff*xDiff) + (yDiff*yDiff) )
end

function getAngle( x1, y1, x2, y2 )
   xDiff = x2 - x1
   yDiff = y2 - y1
   return math.atan2(yDiff, xDiff)
end

function degree2Radian( n )
   return n * (math.pi/180)
end