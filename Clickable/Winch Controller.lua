button_pressed_UP = 0
button_pressed_DOWN = 0

isLocked = false

target_length = 0

winch_Up = false
winch_Down = false

winch_up_but = false
winch_down_but = false
function onTick()
    increment = property.getNumber("Counter Increment")
    dead_zone = property.getNumber("Winch Deadzone")

    isP = input.getBool(1)

    in1X = input.getNumber(3)
    in1Y = input.getNumber(4)
    winch_max = input.getNumber(5)
    winch_length = input.getNumber(6)

    increment = increment*(winch_max/10)

    --Push Buttons
    if isP and isInRect(1,2,14,6,in1X,in1Y) then
        target_length = winch_max
    end

    if (isP and isInRect(1,9,14,6,in1X,in1Y)) then
        target_length = target_length + increment
        winch_up_but = true
    else
        winch_up_but = false
    end

    if (isP and isInRect(1,17,14,6,in1X,in1Y)) then
        target_length = target_length - increment
        winch_down_but = true
    else
        winch_down_but = false
    end

    if isP and isInRect(1,24,14,6,in1X,in1Y) then
        target_length = 0
    end

    --Deal with overflow
    if target_length > winch_max then
        target_length = winch_max
    elseif target_length < 0 then
        target_length = 0
    end

    --Decide Winch Up/Down
    target_length = math.abs(target_length)
    target_length_comp = target_length*10
    target_length_comp = math.floor(target_length_comp)
    target_length_comp = target_length_comp/10

    winch_length_comp = winch_length*10
    winch_length_comp = math.floor(winch_length_comp)
    winch_length_comp = winch_length_comp/10

    length_diff = target_length - winch_length
    length_diff = length_diff*10
    length_diff = math.floor(length_diff)
    length_diff = length_diff/10
    length_diff = math.abs(length_diff)

    if ((target_length_comp < dead_zone) and (winch_length_comp < dead_zone)) then    
        winch_Up = false
        winch_Down = false    
    elseif length_diff < dead_zone then
        winch_Up = false
        winch_Down = false
    elseif target_length_comp > winch_length_comp then
        winch_Up = false
        winch_Down = true
    elseif target_length_comp < winch_length_comp then
        winch_Up = true
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
    winch_ratio = winch_ratio * -28
    setC(0,19,96)
    screen.drawRectF(16, 30, 7, winch_ratio)

    target_ratio = target_length/winch_max
    target_ratio = target_ratio * -28
    setC(255,50,12)
    screen.drawRectF(24, 30, 7, target_ratio)
end

function setC(r,g,b,a)
    if a==nil then a=255 end
        screen.setColor(r,g,b,a)
end