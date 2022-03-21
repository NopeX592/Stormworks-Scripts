zoo = 5
zoom = -1.431
x = 0
y = 0
button_size = 6

function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)
    isPressingCenter = input.getBool(2)

    worldX = input.getNumber(5)
    worldY = input.getNumber(6)

    --Center
	if isPressingCenter then
        x = 0
        y = 0
    end

    --Zoom
	isPressingZoomIn = isPressed and isPntInRect(inputX, inputY, 58, 5, button_size, button_size)
	isPressingZoomOut = isPressed and isPntInRect(inputX, inputY, 58, 11, button_size, button_size)
	
	if isPressingZoomIn then
		zoom = zoom + 0.01
	elseif isPressingZoomOut then
		zoom = zoom - 0.01
	end
    if zoom < -1.431 then
        zoom = -1.431
    end
    if zoom > 2.431 then
        zoom = 2.431
    end
	
    --Panning
	isPressingXPlus = isPressed and isPntInRect(inputX, inputY, 58, 49, button_size, button_size)
	isPressingXMinus = isPressed and isPntInRect(inputX, inputY, 46, 49, button_size, button_size)
	isPressingYPlus = isPressed and isPntInRect(inputX, inputY, 52, 43, button_size, button_size)
	isPressingYMinus = isPressed and isPntInRect(inputX, inputY, 52, 55, button_size, button_size)

    if isPressingXPlus then
        x = x + 0.75*(zoo^(zoom + 1.431))
    elseif isPressingXMinus then
        x = x - 0.75*(zoo^(zoom + 1.431))
    end

    if isPressingYPlus then
        y = y + 0.75*(zoo^(zoom + 1.431))
    elseif isPressingYMinus then
        y = y - 0.75*(zoo^(zoom + 1.431))
    end

    --set outputs
    output.setNumber(7, x)
    output.setNumber(8, y)
    output.setNumber(9, zoom)
end

function isPntInRect(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
	cw = w/2
    ch = h/2

    --Draw Player
    pixelX, pixelY = map.mapToScreen(x+worldX, y+worldY, zoo^zoom, 64, 64, worldX, worldY)
    screen.setColor(200, 20, 20)
    screen.drawRect(pixelX, pixelY, 2, 2)
    screen.setColor(250, 10, 10, 50)
    screen.drawRect(pixelX-1, pixelY-1, 4, 4)
    screen.setColor(255, 255, 255, 100)
    screen.drawCircleF(pixelX+1, pixelY+1, 1)

    --Draw Zoom
    screen.setColor(0,0,0)
    screen.drawTextBox(58, 5, button_size, button_size, "+", 1, 1)
    screen.drawTextBox(58, 11, button_size, button_size, "-", 1, 1)
    screen.drawRect(58, 5, button_size, button_size)
    screen.drawRect(58, 11, button_size, button_size)

    screen.drawLine(61, 20, 61, 42)
    
    screen.setColor(200,20,20)
    screen.drawRectF(58, (zoo^zoom * 19/50) + 20, 7, 3)

    screen.setColor(200,20,20,150)
    if isPressingZoomIn then
        screen.drawRectF(58, 5, button_size+1, button_size+1)
    end
    if isPressingZoomOut then
        screen.drawRectF(58, 11, button_size+1, button_size+1)
    end

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

    screen.setColor(200,20,20,150)
    if isPressingXPlus then
        screen.drawRectF(58, 49, button_size+1, button_size+1)
    end
    if isPressingXMinus then
        screen.drawRectF(46, 49, button_size+1, button_size+1)
    end
    if isPressingYPlus then
        screen.drawRectF(52, 43, button_size+1, button_size+1)
    end
    if isPressingYMinus then
        screen.drawRectF(52, 55, button_size+1, button_size+1)
    end
end