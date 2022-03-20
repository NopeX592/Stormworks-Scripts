i1Toggled = false

i2Toggled = false

i3Toggled = false

i4Toggled = false
start_val1 = property.getNumber("Start Val1")
start_val2 = property.getNumber("Start Val2")
increment1 = property.getNumber("Increment 1")
increment2 = property.getNumber("Increment 2")
value1 = start_val1
value2 = start_val2
max1 = property.getNumber("Max 1")
min1 = property.getNumber("Min 1")
max2 = property.getNumber("Max 2")
min2 = property.getNumber("Min 2")


function onTick()
    isP1 = input.getBool(1)
    isP2 = input.getBool(2)

    in1X = input.getNumber(3)
    in1Y = input.getNumber(4)
    in2X = input.getNumber(5)
    in2Y = input.getNumber(6)

    reset1 = false
    reset2 = false

    if (isP1 and isInRect(0,0,16,11,in1X,in1Y)) or (isP2 and isInRect(0,0,16,11,in2X,in2Y)) then
        i1Toggled=true
        value1 = value1 + increment1
        if value1 > max1 then
            value1 = max1
        end
        output.setNumber(1, value1)
    else
        i1Toggled=false
    end

    if (isP1 and isInRect(16,0,16,11,in1X,in1Y)) or (isP2 and isInRect(16,0,16,11,in2X,in2Y)) then
        i2Toggled=true
        value2 = value2 + increment2
        if value2 > max2 then
            value2 = max2
        end
        output.setNumber(2, value2)
    else
        i2Toggled=false
    end

    if (isP1 and isInRect(0,21,16,11,in1X,in1Y)) or (isP2 and isInRect(0,21,16,11,in2X,in2Y)) then
        i3Toggled=true
        value1 = value1 - increment1
        if value1 < min1 then
            value1 = min1
        end
        output.setNumber(1, value1)
    else
        i3Toggled=false
    end

    if (isP1 and isInRect(16,21,16,11,in1X,in1Y)) or (isP2 and isInRect(16,21,16,11,in2X,in2Y)) then
        i4Toggled=true
        value2 = value2 - increment2
        if value2 < min2 then
            value2 = min2
        end
        output.setNumber(2, value2)
    else
        i4Toggled=false
    end
    if (isP1 and isInRect(0,11,16,10,in1X,in1Y)) or (isP2 and isInRect(0,11,16,10,in2X,in2Y)) then
        value1 = start_val1
        output.setNumber(1, value1)
        reset1 = true
    end
    if (isP1 and isInRect(16,11,16,10,in1X,in1Y)) or (isP2 and isInRect(16,11,16,10,in2X,in2Y)) then
        value2 = start_val2
        output.setNumber(2, value2)
        reset2 = true
    end
end

function onDraw()
    setC(79,3,3)
    screen.drawRectF(0,0,16,11)
    setC(0,0,0)
    screen.drawRectF(0,0,16,11)text="+"
    if i1Toggled then
       text="+"
    end
    if i1Toggled then
        setC(19,96,0)
        screen.drawRectF(0, 0, 16, 11)
    end
    if i1Toggled then
        setC(96,96,96)
    else
        setC(96,96,96)
    end
    screen.drawTextBox(0, 0, 16, 11, text, 0, 0)

    setC(79,3,3)
    screen.drawRectF(16,0,16,11)
    setC(0,0,0)
    screen.drawRectF(16,0,16,11)text="+"
    if i2Toggled then
        text="+"
    end
    if i2Toggled then
        setC(19,96,0)
        screen.drawRectF(16, 0, 16, 11)
    end
    if i2Toggled then
        setC(96,96,96)
    else
        setC(96,96,96)
    end
    screen.drawTextBox(16, 0, 16, 11, text, 0, 0)

    setC(79,3,3)
    screen.drawRectF(0,21,16,11)
    setC(0,0,0)
    screen.drawRectF(0,21,16,11)text="-"
    if i3Toggled then
        text="-"
    end
    if i3Toggled then
        setC(96,0,0)
        screen.drawRectF(0, 21, 16, 11)
    end
    if i3Toggled then
        setC(96,96,96)
    else
        setC(96,96,96)
    end
    screen.drawTextBox(0, 21, 16, 11, text, 0, 0)

    setC(79,3,3)
    screen.drawRectF(16,21,16,11)
    setC(0,0,0)
    screen.drawRectF(16,21,16,11)text="-"
    if i4Toggled then
        text="-"
    end
    if i4Toggled then
        setC(96,1,0)
        screen.drawRectF(16, 21, 16, 11)
    end
    if i4Toggled then
        setC(96,96,96)
    else
        setC(96,96,96)
    end
    screen.drawTextBox(16, 21, 16, 11, text, 0, 0)

    setC(0,0,0)
    screen.drawRectF(0,11,16,10)
    screen.drawRectF(0,11,16,10)
    screen.drawRectF(16,11,16,10)
    screen.drawRectF(16,11,16,10)
    setC(96,96,96)

    if reset1 then
        setC(0,3,96)
        screen.drawRectF(0,11,16,10)
    elseif not reset1 then
        setC(255,255,255)
        value1 = value1 * 10
        value1 = math.floor(value1)
        value1 = value1 / 10
        screen.drawTextBox(0, 11, 16, 10, value1, 0, 0)
    end

    if reset2 then
        setC(0,3,96)
        screen.drawRectF(16,11,16,10)
    elseif not reset2 then
        setC(255,255,255)
        value2 = value2 * 10
        value2 = math.floor(value2)
        value2 = value2 / 10
        screen.drawTextBox(16, 11, 16, 10, value2, 0, 0)
    end
end

function setC(r,g,b,a)
    if a==nil then a=255 end
        screen.setColor(r,g,b,a)
end

function isInRect(x,y,w,h,px,py)
    return px>=x and px<=x+w and py>=y and py<=y+h
end