zoo = 5
zoom = -1.431
x = 0
y = 0
button_size = 6

function onTick()
    inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)

    worldX = input.getNumber(5)
    worldY = input.getNumber(6)

    output.setBool(4, false)

	--Map Snap Controls
	isPressingStart = isPressed and isPntInRect(inputX, inputY, 7, 43, button_size, button_size)
	isPressingCenter = isPressed and isPntInRect(inputX, inputY, 7, 55, button_size, button_size)

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

    --Set Outputs
    output.setNumber(7, x)
    output.setNumber(8, y)
    output.setNumber(9, zoom)

    output.setBool(3, isPressingStart)

    if not (isPressingStart or isPressingCenter or isPressingZoomIn or isPressingZoomOut or isPressingXPlus or isPressingXMinus or isPressingYPlus or isPressingYMinus) then
        output.setBool(4, true)
    end
end

function isPntInRect(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end