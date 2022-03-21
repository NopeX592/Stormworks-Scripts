zoo = 5
zoom = -1.431
button_size = 6

function onTick()
    inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)

    worldX = input.getNumber(5)
    worldY = input.getNumber(6)
    x = input.getNumber(7)
    y = input.getNumber(8)
    zoom = input.getNumber(9)

	--Map Snap Controls
	isPressingStart = isPressed and isPntInRect(inputX, inputY, 7, 43, button_size, button_size)
	isPressingCenter = isPressed and isPntInRect(inputX, inputY, 7, 55, button_size, button_size)

    output.setBool(1, isPressingStart)
    output.setBool(2, isPressingCenter)
end

function isPntInRect(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	cw = w/2
    ch = h/2
    
	--Draw Map	
	screen.setMapColorOcean(14,46,48)
	screen.setMapColorShallows(24,68,72)
	screen.setMapColorLand(90,90,90)
	screen.setMapColorGrass(64,85,48)
	screen.setMapColorSand(100,93,41)
	screen.setMapColorSnow(200,200,200)
	screen.drawMap(x+worldX, y+worldY, zoo^zoom)
    pixelX, pixelY = map.mapToScreen(x+worldX, y+worldY, zoo^zoom, 64, 64, worldX, worldY)
    
    --Draw Map Control Buttons
    screen.setColor(0,0,0)
    screen.drawTextBox(7, 43, button_size, button_size, "S", 1, 1)
    screen.drawTextBox(7, 55, button_size, button_size, "R", 1, 1)
    screen.drawRect(7, 43, button_size, button_size)
    screen.drawRect(7, 55, button_size, button_size)

    screen.setColor(200,20,20,150)
    if isPressingStart then
        screen.drawRectF(7, 43, button_size+1, button_size+1)
    end
    if isPressingCenter then
        screen.drawRectF(7, 55, button_size+1, button_size+1)
    end

    --Draw Coordinates
    screen.setColor(0,0,0)
    screen.drawTextBox(2, 1, 28, button_size, math.floor(worldX), -1, 0)
    screen.drawTextBox(34, 1, 28, button_size, math.floor(worldX), -1, 0)

    --blocker rectangle
    screen.setColor(0,0,0)
    screen.drawRectF(w/3*2+1, 0, w/3, h)
end