zoo = 5
button_size = 6

function onTick()
    inputX = input.getNumber(3)
	inputY = input.getNumber(4)
    isPressed = input.getBool(1)
    buttonPressed = input.getBool(4)

    worldX = input.getNumber(5)
    worldY = input.getNumber(6)
    x = input.getNumber(7)
    y = input.getNumber(8)
    zoom = input.getNumber(9)
    pixelX, pixelY = map.mapToScreen(x+worldX, y+worldY, zoo^zoom, 64, 96, worldX, worldY)

    if isPressed and buttonPressed then
        worldWPX, worldWPY = map.screenToMap(inputX, inputY, zoo^zoom, 64, 96, pixelX, pixelY)    
        output.setNumber(9, worldWPX)
        output.setNumber(10, worldWPY)
    end
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

    --Draw Player
    screen.setColor(200, 20, 20)
    screen.drawRect(pixelX, pixelY, 2, 2)
    screen.setColor(250, 10, 10, 50)
    screen.drawRect(pixelX-1, pixelY-1, 4, 4)
    screen.setColor(255, 255, 255, 100)
    screen.drawCircleF(pixelX+1, pixelY+1, 1)

    --Draw Coordinates
    screen.setColor(0,0,0)
    screen.drawTextBox(2, 1, 28, button_size, math.floor(worldX), -1, 0)
    screen.drawTextBox(34, 1, 28, button_size, math.floor(worldX), -1, 0)

    --Draw Zoom
    screen.setColor(0,0,0)
    screen.drawTextBox(58, 5, button_size, button_size, "+", 1, 1)
    screen.drawTextBox(58, 11, button_size, button_size, "-", 1, 1)
    screen.drawRect(58, 5, button_size, button_size)
    screen.drawRect(58, 11, button_size, button_size)

    screen.drawLine(61, 20, 61, 42)
    
    screen.setColor(200,20,20)
    screen.drawRectF(59, (zoo^zoom * 19/50) + 20, 5, 3)

    --Draw Panning Buttons
    screen.setColor(0,0,0)
    screen.drawTextBox(58, 49, button_size, button_size, "+", 1, 1)
    screen.drawTextBox(46, 49, button_size, button_size, "-", 1, 1)
    screen.drawTextBox(52, 43, button_size, button_size, "+", 1, 1)
    screen.drawTextBox(52, 55, button_size, button_size, "-", 1, 1)
    screen.drawRect(58, 49, button_size, button_size)
    screen.drawRect(46, 49, button_size, button_size)
    screen.drawRect(52, 43, button_size, button_size)
    screen.drawRect(52, 55, button_size, button_size)

    --Draw Map Control Buttons
    screen.setColor(0,0,0)
    screen.drawTextBox(7, 43, button_size, button_size, "S", 1, 1)
    screen.drawTextBox(7, 55, button_size, button_size, "R", 1, 1)
    screen.drawRect(7, 43, button_size, button_size)
    screen.drawRect(7, 55, button_size, button_size)
    
    --blocker rectangle
    screen.setColor(0,0,0)
    screen.drawRectF(w/3*2+1, 0, w/3, h)
end