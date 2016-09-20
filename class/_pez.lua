
Pez = {}
Pez.__index = Pez

function Pez.create( x, y, c )
   local p = {}
   setmetatable(p, Pez)

   if x == nil then
      p.x = 0
   else
      p.x = x
   end

   if y == nil then
      p.y = 0
   else
      p.y = y
   end

   p.color = c
   p.hambre = 3

   p.dirX = 0
   p.movUnidadesX = 0
   p.dirY = 0
   p.movUnidadesY = 0

   return p
end

function Pez:Draw( drawBBox )
   love.graphics.rectangle('fill', self.x, self.y , 20, 20)
   if drawBBox then
      love.graphics.line(self.x, self.y, self.x + self.movUnidadesX*self.dirX, self.y + self.movUnidadesY*self.dirY)
   end

end

function Pez:Update( dt )

         if RELOJ >= RELOJ_LIMITE then
             if self.hambre < 10 then
                self.hambre = self.hambre + 1
             end
         end

         if self.movUnidadesY > 0 and self.dirY ~= 0 then      -- NORTE / SUR
             self.y = self.y + self.dirY
             self.movUnidadesY = self.movUnidadesY - 1
         end

         if self.movUnidadesX > 0 and self.dirX ~= 0 then      -- ESTE / OESTE
             self.x = self.x + self.dirX
             self.movUnidadesX = self.movUnidadesX - 1
         end
end


-- // PEZ FUNCTIONS // --

function Pez:IA()
         if self.hambre >= 10 then
            return "morir"
         elseif self.hambre > 6 then
            return "comer"
         else
            return "mover"
         end
end


-- // GETs // --

function Pez:getPosX()
     return self.x
end

function Pez:getPosY()
     return self.y
end

function Pez:getHambre()
   return self.hambre
end

function Pez:getColor()
     return self.color
end

function Pez:Hambriento()
   return self.hambre >= 6
end


-- // SETs // --

function Pez:PonerDestino(dx, ux, dy, uy)
   self.dirX = dx
   self.movUnidadesX = ux
   self.dirY = dy
   self.movUnidadesY = uy
end

function Pez:Parar()
   self.dirX = 0
   self.movUnidadesX = 0
   self.dirY = 0
   self.movUnidadesY = 0
end

function Pez:Alimentar( comida )
   if self.hambre > 0 then
      self.hambre = self.hambre - 1
   end
end


-- // INFO // --

function Pez:printInfo()
         print("Pez - Color: "..self.color.." - [X,Y]: ["..self.x..","..self.y.."]")
end
