button_size = 6

function onTick()
    inputX = input.getNumber(3)
	inputY = input.getNumber(4)
    isPressed = input.getBool(1)

    worldX = input.getNumber(7)
    worldY = input.getNumber(8)
    x_off = input.getNumber(9)
    y_off = input.getNumber(10)
    zoom = input.getNumber(11)
    pixelX, pixelY = map.mapToScreen(x_off+worldX, y_off+worldY, zoom, 64, 64, worldX, worldY)

    --Set Outputs
    output.setNumber(7, worldX)
    output.setNumber(8, worldY)
    output.setNumber(9, x_off)
    output.setNumber(10, y_off)
    output.setNumber(11, zoom)
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
	screen.drawMap(x_off+worldX, y_off+worldY, zoom)

    --Draw Player
    screen.setColor(200,20,20,100)
    screen.drawRectF(pixelX-3, pixelY-3, button_size, button_size)
    screen.setColor(200,20,20)
    screen.drawRectF(pixelX-2, pixelY-2, button_size-2, button_size-2)

    --Draw Zoom
    screen.setColor(0,0,0)
    screen.drawTextBox(57, 5, button_size, button_size, "+", 1, 1)
    screen.drawTextBox(57, 11, button_size, button_size, "-", 1, 1)
    screen.drawRect(57, 5, button_size, button_size)
    screen.drawRect(57, 11, button_size, button_size)

    screen.drawLine(60, 20, 60, 42)
    
    screen.setColor(200,20,20)
    screen.drawRectF(58, (5^zoom * 19/50) + 20, 5, 3)

    --Draw Panning Buttons
    screen.setColor(0,0,0)
    screen.drawTextBox(57, 49, button_size, button_size, "+", 1, 1)
    screen.drawTextBox(45, 49, button_size, button_size, "-", 1, 1)
    screen.drawTextBox(51, 43, button_size, button_size, "+", 1, 1)
    screen.drawTextBox(51, 55, button_size, button_size, "-", 1, 1)
    screen.drawRect(57, 49, button_size, button_size)
    screen.drawRect(45, 49, button_size, button_size)
    screen.drawRect(51, 43, button_size, button_size)
    screen.drawRect(51, 55, button_size, button_size)

    --Draw Map Control Buttons
    screen.setColor(0,0,0)
    screen.drawTextBox(5, 55, button_size, button_size, "C", 1, 1)
    screen.drawRect(6, 55, button_size, button_size)
end