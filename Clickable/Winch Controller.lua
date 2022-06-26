button_pressed_UP = 0
button_pressed_DOWN = 0

isLocked = false

target_length = 0

winch_Up = false
winch_Down = false

winch_up_ALL = false
winch_down_ALL = false

winch_up_but = false
winch_down_but = false
function onTick()
    increment = property.getNumber("Counter Increment")

    isP = input.getBool(1)

    in1X = input.getNumber(3)
    in1Y = input.getNumber(4)
    winch_max = input.getNumber(5)
    winch_length = input.getNumber(6)

    --Push Buttons
    if (isP and isInRect(1,9,14,6,in1X,in1Y)) then
        target_length = target_length - increment
        winch_up_but = true
    else
        winch_up_but = false
    end

    if (isP and isInRect(1,17,14,6,in1X,in1Y)) then
        target_length = target_length + increment
        winch_down_but = true
    else
        winch_down_but = false
    end

    --Toggle Buttons
    if not (isPBU or isPBD) then
        isLocked = false
    end

    isPBU = isP and isInRect(1,2,14,6,in1X,in1Y)
    isPBD = isP and isInRect(1,24,14,6,in1X,in1Y)

    if not isLocked then
        if isPBU then
            button_pressed_UP = button_pressed_UP + 1
            target_length = 0
            winch_up_ALL = true
        end

        if isPBD then
            button_pressed_DOWN = button_pressed_DOWN + 1
            target_length = winch_max
            winch_down_ALL = true
        end
        isLocked = true
    end

    --Reset Toggle Buttons
    if button_pressed_UP == 2 then
        button_pressed_UP = 0
        winch_up_ALL = false
    end

    if button_pressed_DOWN == 2 then
        button_pressed_DOWN = 0
        winch_down_ALL = false
    end

    --Decide Winch Up/Down
    if target_length > winch_length then
        winch_Up = true
    elseif target_length < winch_length then
        winch_Down = true
    else
        winch_Up = false
        winch_Down = false
    end
    --Set Outputs
    output.setBool(1,winch_Up)
    output.setBool(2,winch_Down)
end

function isInRect(x,y,w,h,px,py)
    return px>=x and px<=x+w and py>=y and py<=y+h
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()

    setC(57,57,57)
    screen.drawRectF(1, 2, 14, 6)
    screen.drawRectF(1, 9, 14, 6)
    screen.drawRectF(1, 17, 14, 6)
    screen.drawRectF(1, 24, 14, 6)

    --Draw Buttons
    setC(19,96,0)
    if winch_up_ALL then
        screen.drawRectF(1, 2, 14, 6)
    end

    if winch_up_but then
        screen.drawRectF(1, 9, 14, 6)
    end

    setC(96,19,0)
    if winch_down_but then
        screen.drawRectF(1, 17, 14, 6)
    end

    if winch_down_ALL then
        screen.drawRectF(1, 24, 14, 6)
    end

    setC(255,255,255)
    screen.drawTextBox(1, 2, 14, 6, "++", 0, 0)
    screen.drawTextBox(1, 9, 14, 6, "+", 0, 0)
    screen.drawTextBox(1, 17, 14, 6, "-", 0, 0)
    screen.drawTextBox(1, 24, 14, 6, "--", 0, 0)

    --Draw Bars
    winch_ratio = winch_length/winch_max
    winch_ratio = winch_ratio * 28
    setC(0,19,96)
    screen.drawRectF(16, 2, 7, winch_ratio)

    target_ratio = target_length/winch_max
    target_ratio = target_ratio * 28
    setC(255,127,39)
    screen.drawRectF(24, 2, 7, target_ratio)
end

function setC(r,g,b,a)
    if a==nil then a=255 end
        screen.setColor(r,g,b,a)
end