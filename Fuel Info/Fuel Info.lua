function onTick()
	fuel_level = input.getNumber(1)
    fuel_capacity = input.getNumber(2)
	fuel_consumption= input.getNumber(2)

	hrs = math.floor(fuel_consumption+0.5)/3600
	round = hrs % 0.001
	hrs = hrs - round
    
    fuel_ratio = fuel_level/fuel_capacity
    fuel_value = fuel_ratio*100
    fuel_value = math.floor(fuel_value)
    
    bingo_level = property.getNumber("Bingo Level")
    bingo_ratio = bingo_level/fuel_capacity

	green_level = fuel_capacity-bingo_level
	green_ratio = green_level/fuel_capacity
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	draw_height = (fuel_ratio * (h-3))
	draw_height = math.floor(draw_height)
    bingo_height = (bingo_ratio * (h-3))
    bingo_height = math.floor(bingo_height)
	green_height = (green_ratio * (h-3))
    green_height = math.floor(green_height)
	
	if fuel_level > green_level then --draw fuel gauge
		setC(0,122,0)
	    screen.drawRectF(2, 31, 5, -1*draw_height)
    elseif fuel_level < bingo_level then
    	setC(122,0,0)
	    screen.drawRectF(2, 31, 5, -1*draw_height)
    else
    	setC(50,50,0)
	    screen.drawRectF(2, 31, 5, -1*draw_height)
	end

	if fuel_level > green_level then --draw fuel value
		setC(0,122,0)
		screen.drawTextBox(10, 2, w-16, 7, fuel_value, 1, 0)
	    screen.drawTextBox(10, 2, w-11, 7, "%", 1, 0)
    elseif fuel_level < bingo_level then
    	setC(122,0,0)
		screen.drawTextBox(10, 2, w-16, 7, fuel_value, 1, 0)
	    screen.drawTextBox(10, 2, w-11, 7, "%", 1, 0)
    else
	    setC(255,255,255)
	    screen.drawTextBox(10, 2, w-16, 7, fuel_value, 1, 0)
	    screen.drawTextBox(10, 2, w-11, 7, "%", 1, 0)
	end
	setC(12,12,12) --draw border
    screen.drawRect(1, 1, 6, h-2)
  
    setC(122,0,0) --draw bingo line
    screen.drawLine(8, h-2-bingo_height, 12, h-2-bingo_height)
	setC(0,122,0) --draw green line
    screen.drawLine(8, h-2-green_height, 12, h-2-green_height)

	screen.drawText(4, 4, math.floor((fuel_consumption+0.5)/60)) --draw remaining time
	screen.drawText(4, 10, 'min')
	screen.drawText(4, 16, hrs)
	screen.drawText(4, 22, 'hrs')
end

function setC(r,g,b,a)
    if a==nil then a=255 end
    screen.setColor(r,g,b,a)
end