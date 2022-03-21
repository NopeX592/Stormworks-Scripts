zoom = -0.5
x_off = 0
y_off = 0
button_size = 8
isLocked = false

function onTick()
    inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)

    worldX = input.getNumber(7)
    worldY = input.getNumber(8)

    if not (isPressingBack) then
        isLocked = false
    end

    --Reset
    isPressingReset = isPressed and isPntInRect(inputX, inputY, 0, 49, button_size, button_size)
	--Back
    backPressed = false
    isPressingBack = isPressed and isPntInRect(inputX, inputY, 12, 49, button_size, button_size)
    if not isLocked then
        isLocked = true
        if isPressingBack then
            backPressed = true
        end
    end

    --Start Autopilot
    isPressingStart = isPressed and isPntInRect(inputX, inputY, 6, 43, button_size, button_size)

    --Center
    isPressingCenter = isPressed and isPntInRect(inputX, inputY, 6, 55, button_size, button_size)

    if isPressingCenter then
       x_off = 0
       y_off = 0
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
    output.setNumber(9, x_off)
    output.setNumber(10, y_off)
    output.setNumber(11, zoom)

    output.setBool(3, isPressingStart)
    output.setBool(4, isPressingReset)
    output.setBool(5, backPressed)

    if isPressed and (not (isPressingReset or isPressingBack or isPressingStart or isPressingCenter or isPressingZoomIn or isPressingZoomOut or isPressingXPlus or isPressingXMinus or isPressingYPlus or isPressingYMinus)) then
        worldWPX, worldWPY = map.screenToMap(x_off+worldX, y_off+worldY, zoom, 64, 64, inputX, inputY)
        output.setNumber(12, worldWPX)
        output.setNumber(13, worldWPY)
    end
end

function isPntInRect(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end