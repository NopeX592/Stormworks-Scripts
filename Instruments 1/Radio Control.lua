i14Toggled = false
i15Toggled = false
i18Toggled = false
i18ToggledP = false
isLocked = false
frequency = 0

function onTick()
    isP1 = input.getBool(1)
    isP2 = input.getBool(2)
    isReceiving = input.getBool(3)

    signal_strength = input.getNumber(1)
    time = input.getNumber(2)
    time = math.floor(time) + 0.60*(time-math.floor(time))
    
    in1X = input.getNumber(3)
    in1Y = input.getNumber(4)
    in2X = input.getNumber(5)
    in2Y = input.getNumber(6)

    shift = 0

    if not (iPBu or iPBd) then
    	isLocked = false
    end

    iPBu = (isP1 or isP2) and isInRect(25+shift, 25, 8, 7, in1X, in1Y)
    iPBd = (isP1 or isP2) and isInRect(0+shift, 25, 8, 7, in1X, in1Y)

    if not isLocked then
        if iPBu then
            frequency = frequency + 1
            if frequency == 9 then
                frequency = 0
            end
        end

        if iPBd then
            frequency = frequency - 1
            if frequency == -1 then
                frequency = 8
            end
        end
        frequency = math.floor(frequency)
        output.setNumber(7, frequency)

        isLocked = true
    end

    if (isP1 and isInRect(7+shift,25,17,7,in1X,in1Y)) or (isP2 and isInRect(8+shift,25,17,7,in2X,in2Y)) then
        i18ToggledP=true
        output.setBool(2, i18ToggledP)
    end
    if not (isP1 or isP2) and i18ToggledP then
        i18ToggledP = false
        i18Toggled = not i18Toggled
    end
end

function onDraw()
    setC(0,0,0)
    screen.drawRectF(0+shift,0,32,9)
    screen.drawRectF(0+shift,0,32,9)
    screen.drawRectF(0+shift,9,16,9)
    screen.drawRectF(0+shift,9,16,9)
    screen.drawRectF(26+shift,9,6,9)
    screen.drawRectF(26+shift,9,6,9)

    setC(96,96,96)
    screen.drawTextBox(0+shift, 0, 32, 9, string.format("%.2f", time), 0, 0)
    screen.drawTextBox(0+shift, 9, 16, 9, "CH:", 0, 0)
    screen.drawTextBox(26+shift, 9, 6, 9, frequency, 0, 0)

    setC(0,0,0)
    screen.drawRectF(25+shift,25,7,7)
    screen.drawRectF(25+shift,25,8,7)text=">"
    if i14Toggled then
        text=">"
    end
    if iPBu then
        setC(0,96,1)
        screen.drawRectF(25+shift, 25, 7, 7)
    end
    if i14Toggled then
        setC(96,96,96)
    else
    setC(96,96,96)
    end
    screen.drawTextBox(25+shift, 25, 7, 7, text, 0, 0)

    setC(0,0,0)
    screen.drawRectF(0+shift,25,8,7)
    setC(0,0,0)
    screen.drawRectF(0+shift,25,8,7)text="<"
    if i15Toggled then
        t="<"
    end
    if iPBd then
        setC(96,0,0)
        screen.drawRectF(0+shift, 25, 8, 7)
    end
    if i15Toggled then
        setC(96,96,96)
    else
        setC(96,96,96)
    end
    screen.drawTextBox(0+shift, 25, 8, 7, text, 0, 0)

    setC(0,0,0)
    screen.drawRectF(0+shift,17,16,8)
    screen.drawRectF(0+shift,17,16,8)
    screen.drawRectF(8+shift,25,17,7)

    if isReceiving then
        setC(0,125,25)
        screen.drawTextBox(0+shift, 17, 16, 8, "COM", 0, 0)
    elseif not isReceiving then
        setC(96,96,96)
        screen.drawTextBox(0+shift, 17, 16, 8, "COM", 0, 0)
    end

    setC(96,96,96)
    screen.drawLine(23+shift, 23, 23+shift, 22)
    screen.drawLine(25+shift, 23, 25+shift, 21)
    screen.drawLine(27+shift, 23, 27+shift, 20)
    screen.drawLine(29+shift, 23, 29+shift, 19)
    screen.drawLine(31+shift, 23, 31+shift, 18)

    if signal_strength > 0.05 then
        setC(255,0,0)
        screen.drawLine(23+shift, 23, 23+shift, 22)
    end
    if signal_strength > 0.4 then
        setC(255,50,0)
        screen.drawLine(25+shift, 23, 25+shift, 21)
    end
    if signal_strength > 0.6 then
        setC(255,175,0)
        screen.drawLine(27+shift, 23, 27+shift, 20)
    end
    if signal_strength > 0.8 then
        setC(50,255,0)
        screen.drawLine(29+shift, 23, 29+shift, 19)
    end
    if signal_strength > 0.95 then
        setC(0,255,0)
        screen.drawLine(31+shift, 23, 31+shift, 18)
    end

    setC(0,0,0)
    screen.drawRectF(7+shift,25,17,7)text="SPK"
    if i18Toggled then
        text="SPK"
    end
    if i18Toggled then
        setC(0,0,96)
        screen.drawRectF(8+shift, 25, 17, 7)
    end
    if i18Toggled then
        setC(96,96,96)
    else
        setC(96,96,96)
    end
    screen.drawTextBox(8+shift, 25, 17, 7, text, 0, 0)
end

function setC(r,g,b,a)
    if a==nil then a=255 end
    screen.setColor(r,g,b,a)
end

function rotatePoint(cx,cy,angle,px,py)
    s=math.sin(angle)
    c=math.cos(angle)
    px=px-cx
    py=py-cy
    xnew=px*c-py*s
    ynew=px*s+py*c
    px=xnew+cx
    py=ynew+cy
    return {x=px,y=py}
end

function isInRect(x,y,w,h,px,py)
    return px>=x and px<=x+w and py>=y and py<=y+h
end

