function onTick()
	fuel_level = input.getNumber(1)
    fuel_capacity = input.getNumber(2)
    
    fuel_ratio = fuel_level/fuel_capacity
    fuel_value = fuel_ratio*100
    fuel_value = math.floor(fuel_value)
    
    bingo_level = property.getNumber("Bingo Level")
    bingo_ratio = bingo_level/fuel_capacity
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	draw_height = (fuel_ratio * (h-3))
	draw_height = math.floor(draw_height)
    bingo_height = (bingo_ratio * (h-3))
    bingo_height = math.floor(bingo_height)
	
	if	fuel_level > bingo_level then
	    setC(50,50,0) --draw fuel gauge
	    screen.drawRectF(2, 31, 5, -1*draw_height)
    else
    	setC(122,0,0) --draw fuel gauge
	    screen.drawRectF(2, 31, 5, -1*draw_height)
	end
    setC(12,12,12)
    screen.drawRect(1, 1, 6, h-2)
    
    setC(122,0,0) --draw bingo line
    screen.drawLine(8, h-3-bingo_height, 12, h-3-bingo_height)
    
	if	fuel_level > bingo_level then
	    setC(255,255,255) --draw fuel value
	    screen.drawTextBox(10, 2, w-15, 7, fuel_value, 1, 0)
	    screen.drawTextBox(10, 2, w-10, 7, "%", 1, 0)
    else
    	setC(122,0,0) --draw fuel value
	    screen.drawTextBox(10, 2, w-15, 7, fuel_value, 1, 0)
	    screen.drawTextBox(10, 2, w-10, 7, "%", 1, 0)
	end
end

function setC(r,g,b,a)
    if a==nil then a=255 end
    screen.setColor(r,g,b,a)
end