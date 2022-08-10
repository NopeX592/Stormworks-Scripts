w = 32
h = 32
set_range = -35000

function onTick()
	inputX = input.getNumber(3)
	inputY = input.getNumber(4)
	isPressed = input.getBool(1)

    off_button = input.getBool(3)
    max_range = input.getNumber(5)

    --Range Multiplier
    range_mult = max_range/7500

    --Range Buttons
    isPressingRangeMinus = isPressed and isPointInRectangle(inputX, inputY, 0, 0, w/2, h)
    isPressingRangePlus = isPressed and isPointInRectangle(inputX, inputY, w/2, 0, w/2, h)

    if not off_button then
        set_range = -35000
    end
    if isPressingRangeMinus then
        set_range = set_range - (10 * range_mult)
    end
    if isPressingRangePlus then
        set_range = set_range + (10 * range_mult)
    end
    if set_range < 3500 then
        set_range = 3500
    end
    if set_range > max_range then
        set_range = max_range
    end
    output.setNumber(7, set_range)
end

function onDraw()
    --Draw Circle
    screen.setColor(0,255,0)
    screen.drawCircle(w/2-0.5, h/2-0.5, 15.5)
    screen.setColor(0,255,0,75)
    screen.drawCircle(w/2-0.5, h/2-0.5, 10.5)
    screen.drawCircle(w/2-0.5, h/2-0.5, 5)

    --Draw Range
    screen.setColor(255,255,255)
    text_range = set_range/100
    text_range = math.floor(text_range)
    text_range = text_range/10
    screen.drawTextBox(0, 26, 24, 6, text_range, -1, 0)
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end