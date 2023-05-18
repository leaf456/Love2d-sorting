local list = {}
local dosort = false
local iteration = 0
local isdone = false
local supermode = false
local multiplier = 1
function randomiselist(n, maxheight)
	list[1] = 0
	for i = 2, n do
		list[i] = list[i - 1] + maxheight / n
	end
	for i = 1, n * 3 do
		replacevalue(math.random(1, n), math.random(1, n))
	end
end
function replacevalue(i1, i2) local orival1 = list[i1] list[i1] = list[i2] list[i2] = orival1 end
function doline()
	isdone = true
	for i = 1, #list do
		if list[i + 1] ~= nil then if list[i + 1] < list[i] then replacevalue(i, i + 1) isdone = false end end
	end
end
function love.load()
	love.window.setMode(love.graphics.getWidth(), love.graphics.getHeight(), {resizable=true})
	love.window.maximize()
	randomiselist(love.graphics.getWidth() * multiplier, love.graphics.getHeight() * multiplier)
end
function love.draw()
	for i = 1, #list do
		if isdone then love.graphics.setColor(0.1, 1, 0.1) else love.graphics.setColor(1, 1, 1) end
		love.graphics.rectangle("fill", i / multiplier, love.graphics.getHeight(), 1, (0 - list[i]) / multiplier)
	end
	love.graphics.setColor(1, 1, 1)
	if dosort then love.graphics.print("Sorting. press space to stop, r to reset, s for super mode.", 5, 5)else 
	love.graphics.print("Idle. press space to start, r to reset, s for super mode.", 5, 5) end 
	love.graphics.print("Current iteration: "..iteration, 5, 20)
	love.graphics.print("Amount of numbers: "..#list, 5, 35)
	if isdone then love.graphics.print("Done!", 5, 50) end
end
function love.keypressed(key)
	if key == "space" then
		if not dosort then dosort = true else dosort = false end
	end if key == "r" then randomiselist(love.graphics.getWidth() * multiplier, love.graphics.getHeight() * multiplier) 
	iteration = 0 isdone = false dosort = true end
	if key == "s" then if not supermode then supermode = true else supermode = false end end
end
function love.update()
	if dosort then
		doline()
		if supermode then for i = 1, 5 * multiplier do doline() end iteration = iteration + 5 * multiplier else
		iteration = iteration + 1 end
		if isdone then dosort = false end
	end
end