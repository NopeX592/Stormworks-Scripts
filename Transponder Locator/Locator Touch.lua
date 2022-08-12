zoom = -0.5
x_off = 0
y_off = 0
button_size = 8

function onTick()
    inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)

    worldX = input.getNumber(7)
    worldY = input.getNumber(8)

    --Center
    isPressingCenter = isPressed and isPntInRect(inputX, inputY, 6, 55, button_size, button_size)

    if isPressingCenter then
       x_off = 0
       y_off = 0
       zoom = -0.5
    end

    --Zoom
	isPressingZoomIn = isPressed and isPntInRect(inputX, inputY, 56, 5, button_size, button_size)
	isPressingZoomOut = isPressed and isPntInRect(inputX, inputY, 56, 11, button_size, button_size)
	
	if isPressingZoomIn then
		zoom = zoom - 0.01
	elseif isPressingZoomOut then
		zoom = zoom + 0.01
	end
    if zoom < -1.431 then
        zoom = -1.431
    end
    if zoom > 2.431 then
        zoom = 2.431
    end
	
    --Panning
	isPressingXPlus = isPressed and isPntInRect(inputX, inputY, 56, 49, button_size, button_size)
	isPressingXMinus = isPressed and isPntInRect(inputX, inputY, 44, 49, button_size, button_size)
	isPressingYPlus = isPressed and isPntInRect(inputX, inputY, 50, 43, button_size, button_size)
	isPressingYMinus = isPressed and isPntInRect(inputX, inputY, 50, 55, button_size, button_size)

    if isPressingXPlus then
        x_off = x_off + 0.75*5^(zoom + 1.431)
    elseif isPressingXMinus then
        x_off = x_off - 0.75*5^(zoom + 1.431)
    end

    if isPressingYPlus then
        y_off = y_off + 0.75*5^(zoom + 1.431)
    elseif isPressingYMinus then
        y_off = y_off - 0.75*5^(zoom + 1.431)
    end

    --Set Outputs
    output.setNumber(7, worldX)
    output.setNumber(8, worldY)
    output.setNumber(9, x_off)
    output.setNumber(10, y_off)
    output.setNumber(11, zoom)
end

function isPntInRect(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end