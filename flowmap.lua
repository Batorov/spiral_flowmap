FlowMap = {}
FlowMap.__index = FlowMap

function FlowMap:create (size)
    local map = {}
    setmetatable(map, FlowMap)
    map.field = {}
    map.size = size
    love.math.setRandomSeed(10000)
    return map
end 

function FlowMap:init()
	local cols = width/self.size
	local rows = height/self.size
	local phi = -math.pi/5
	local k = 1
	local i = 0
	local j = 1
	local ni = 1
	local nj = 0
	local nc = cols
	local nr = rows
	for k = 0, cols do self.field[k]={} end
	for k = 1, cols*rows do
		i=i+ni
		j=j+nj
		if ni==1 and nj==0 or ni==-1 and nj==0 then
			phi=phi+(math.pi/2)/(nc)
		else
			phi=phi+(math.pi/2)/(nr)
		end
		self.field[i][j]=Vector:create(math.cos(phi), math.sin(phi))		
		if i+ni>cols or i+ni<1 or j+nj>rows or j+nj<0 or self.field[i+ni][j+nj] then
			if ni==1 and nj==0 then 
				ni=0
				nj=1
				nr=nr-1
				--phi = math.pi/2
			elseif ni==0 and nj==1 then 
				ni=-1
				nj=0
				nc=nc-1
				--phi = math.pi
			elseif ni==-1 and nj==0 then 
				ni=0
				nj=-1
				nr=nr-1
				--phi = -math.pi/2
			elseif ni==0 and nj==-1 then 
				ni=1
				nj=0
				nc=nc-1
				--phi = 0
			end
		end
	end
end

function FlowMap:lookup(v)
	local col = math.constrain(math.floor(v.x/self.size)+1, 1, #self.field)
	local row = math.constrain(math.floor(v.y/self.size)+1, 1, #self.field[1])
	return self.field[col][row]:copy()

	--local col = math.floor(v.x/self.size) % #self.field[1]
	--local row = math.floor(v.y/self.size) % #self.field
	--return self.field[row+1][col+1]:copy()
end

function FlowMap:draw()
	for i = 1, #self.field do
		for j = 1, #self.field[1] do
			--drawVector(self.field[i][j], (i-1) * self.size, (j-1) * self.size, self.size-2)
			drawVector(self.field[i][j], (i-1) * self.size, j * self.size, self.size-2)
		end
	end
end

function drawVector(v, x, y, s)
	love.graphics.push()
	love.graphics.translate(x,y)
	love.graphics.rotate(v:heading())
	local len = v:mag() * s
	love.graphics.line(0,0,len,0)
	love.graphics.circle("fill",len,0,5)
	love.graphics.pop()
end
