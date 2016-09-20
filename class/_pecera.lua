
Pecera = {}
Pecera.__index = Pecera

function Pecera.create( w, h )
   local p = {}
   setmetatable(p, Pecera)

   if w == nil then
      p.width = 640
   else
      p.width = w
   end

   if h == nil then
      p.height = 480
   else
      p.height = h
   end

   p.x = (SCREEN_W - p.width)/2
   p.y = (SCREEN_H - p.height)/2
                       
   p.peces = {}
   p.comida = {}
   p.comida.x = math.random(p.x + 10, p.x + p.width - 10)
   p.comida.y = math.random(p.y + 10, p.y + p.height - 10)
   p.comida.cantidad = math.random(10, 100)

   return p
end

function Pecera:Draw( drawBBox )

   love.graphics.draw(IMGS["background"])
   
   love.graphics.setColor(5, 57, 128, 255)
   love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
   
   love.graphics.setColor(94, 149, 224, 175)
   love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

   love.graphics.setColor(255, 189, 123, 255)
   love.graphics.circle('fill', self.comida.x, self.comida.y, 10, 16)

   love.graphics.setColor(10, 10, 10, 255)
   love.graphics.print(self.comida.cantidad, self.comida.x - 8, self.comida.y-8)

   love.graphics.setColor(255, 255, 255, 255)


   for i = 1, #self.peces do
      self.peces[i]:Draw(drawBBox)
   end
end

function Pecera:Update( dt )
         local x, y

         for i = 1, #self.peces do
            self.peces[i]:Update(dt)

            x = self.peces[i]:getPosX()
            y = self.peces[i]:getPosY()

            if self.peces[i]:Hambriento() and self.comida.cantidad > 1 and insideBox (x, y, self.comida.x - 10, self.comida.y - 10, 20, 20) then
               self.peces[i]:Alimentar( 2 )
               self.comida.cantidad = self.comida.cantidad - 2
            end

         end
end


-- // FUNCIONES PECERA // --

function Pecera:Empezar()
         print("\n-----------------------------------------")
         print("Llenando nueva pecera...")
         print("-----------------------------------------")
         local x, y
         self.peces = {}
         for i = 1, 5 do
             x = math.random(PECERA:getPosX(), PECERA:get_Width())
             y = math.random(PECERA:getPosY(), PECERA:get_Height())
             PECERA:NuevoPez(x, y, "negro" )
         end

         self.comida.x = math.random(self.x + 10, self.x + self.width - 10)
         self.comida.y = math.random(self.y + 10, self.y + self.height - 10)
         self.comida.cantidad = math.random(10, 100)
end

function Pecera:NuevoPez( x, y, color )
         local pez = Pez.create(x, y, color)
         table.insert(self.peces, pez)
         pez:printInfo()
end

function Pecera:IA()
         if #self.peces > 0 then
           local elegido = math.random(1, #self.peces)
           local r = self.peces[elegido]:IA(dt)
           
           if r == "morir" then        -- MORIR
              print("Un pez de color "..self.peces[elegido]:getColor().." ha muerto.")
              table.remove(self.peces, elegido)
              

           elseif r == "comer" then    -- COMER

             local x, y, unidadesX, unidadesY, dirX, dirY

             x = self.peces[elegido]:getPosX()
             y = self.peces[elegido]:getPosY()

             if self.comida.x > x then
                unidadesX = self.comida.x - x
                dirX = 1
             else
                unidadesX = x - self.comida.x
                dirX = -1
             end
             
             if self.comida.y > y then
                unidadesY = self.comida.y - y
                dirY = 1
             else
                unidadesY = y - self.comida.y
                dirY = -1
             end

             self.peces[elegido]:PonerDestino(dirX, unidadesX, dirY, unidadesY)


           elseif r == "mover" then      -- MOVER
             local x, y, dirX, dirY, unidadesX, unidadesY
             local limite_inferiorX, limite_superiorX, limite_inferiorY, limite_superiorY

             x = self.peces[elegido]:getPosX()
             y = self.peces[elegido]:getPosY()

             dirX = math.random(-1, 1)
             dirY = math.random(-1, 1)

             limite_superiorX = 80
             limite_superiorY = 80

             if dirY == -1 and y - self.y <= 80 then     -- NORTE
                   limite_superiorY = y - self.y

             elseif dirY == 1 and  self.y + self.height - y <= 80 then  -- SUR
                   limite_superiorY = self.y + self.height - y

             end

             if dirX == -1 and x - self.x <= 80  then     -- OESTE
                   limite_superiorX = x - self.x

             elseif dirX == 1 and self.x + self.width - x <= 80 then  -- ESTE
                   limite_superiorX = self.x + self.width - x

             end

             limite_inferiorX = limite_superiorX/2
             limite_inferiorY = limite_superiorY/2

             unidadesX = math.random(limite_inferiorX, limite_superiorX)
             unidadesY = math.random(limite_inferiorY, limite_superiorY)

             self.peces[elegido]:PonerDestino(dirX, unidadesX, dirY, unidadesY)
           end
         end
end


-- // GETs // --

function Pecera:getPosX()
     return self.x
end

function Pecera:getPosY()
     return self.y
end

function Pecera:get_Width()
     return self.width
end

function Pecera:get_Height()
     return self.height
end



-- // SETs // --



-- // INFO // --

function Pecera:printInfo()
end
