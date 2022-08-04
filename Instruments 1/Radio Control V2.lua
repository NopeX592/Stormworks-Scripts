isLocked = false
frequency1 = 0
frequency2 = 0
frequency3 = 0
frequency4 = 0

function onTick()
    isP = input.getBool(1)
    isReceiving = input.getBool(3)

    signal_strength = input.getNumber(1)
    
    inX = input.getNumber(3)
    inY = input.getNumber(4)

    freq = "wxyz"

    if not (isPU1 or isPU2 or isPU3 or isPU4 or isPD1 or isPD2 or isPD3 or isPD4) then
    	isLocked = false
    end

    isPU1 = isP and isInRect(2, 3, 6, 6, inX, inY)
    isPU2 = isP and isInRect(9, 3, 6, 6, inX, inY)
    isPU3 = isP and isInRect(16, 3, 6, 6, inX, inY)
    isPU4 = isP and isInRect(23, 3, 6, 6, inX, inY)

    isPD1 = isP and isInRect(2, 23, 6, 6, inX, inY)
    isPD2 = isP and isInRect(9, 23, 6, 6, inX, inY)
    isPD3 = isP and isInRect(16, 23, 6, 6, inX, inY)
    isPD4 = isP and isInRect(23, 23, 6, 6, inX, inY)

    if not isLocked then
        if isPU1 then
            frequency1 = frequency1 + 1
            if frequency1 == 10 then
                frequency1 = 0
            end
        end
        if isPU2 then
            frequency2 = frequency2 + 1
            if frequency2 == 10 then
                frequency2 = 0
            end
        end
        if isPU3 then
            frequency3 = frequency3 + 1
            if frequency3 == 10 then
                frequency3 = 0
            end
        end
        if isPU4 then
            frequency4 = frequency4 + 1
            if frequency4 == 10 then
                frequency4 = 0
            end
        end

        if isPD1 then
            frequency1 = frequency1 - 1
            if frequency1 == -1 then
                frequency1 = 9
            end
        end
        if isPD2 then
            frequency2 = frequency2 - 1
            if frequency2 == -1 then
                frequency2 = 9
            end
        end
        if isPD3 then
            frequency3 = frequency3 - 1
            if frequency3 == -1 then
                frequency3 = 9
            end
        end
        if isPD4 then
            frequency4 = frequency4 - 1
            if frequency4 == -1 then
                frequency4 = 9
            end
        end
        isLocked = true
    end

    freq = string.gsub(freq, "w", frequency1)
    freq = string.gsub(freq, "x", frequency2)
    freq = string.gsub(freq, "y", frequency3)
    freq = string.gsub(freq, "z", frequency4) 

	freq = tonumber(freq)
    output.setNumber(1, freq)
end

function isInRect(x,y,w,h,px,py)
    return px>=x and px<=x+w and py>=y and py<=y+h
end

function onDraw()
    setC(0,255,0)
    if isPU1 then
        screen.drawRectF(2, 3, 6, 6)
    end
    if isPU2 then
        screen.drawRectF(9, 3, 6, 6)
    end
    if isPU3 then
        screen.drawRectF(16, 3, 6, 6)
    end
    if isPU4 then
        screen.drawRectF(23, 3, 6, 6)
    end

    setC(255,0,0)
    if isPD1 then
        screen.drawRectF(2, 23, 6, 6)
    end
    if isPD2 then
        screen.drawRectF(9, 23, 6, 6)
    end
    if isPD3 then
        screen.drawRectF(16, 23, 6, 6)
    end
    if isPD4 then
        screen.drawRectF(23, 23, 6, 6)
    end

    setC(255,255,255)
    screen.drawTextBox(2, 3, 6, 6, "+", 0, 0)
    screen.drawTextBox(9, 3, 6, 6, "+", 0, 0)
    screen.drawTextBox(16, 3, 6, 6, "+", 0, 0)
    screen.drawTextBox(23, 3, 6, 6, "+", 0, 0)

    screen.drawTextBox(2, 23, 6, 6, "-", 0, 0)
    screen.drawTextBox(9, 23, 6, 6, "-", 0, 0)
    screen.drawTextBox(16, 23, 6, 6, "-", 0, 0)
    screen.drawTextBox(23, 23, 6, 6, "-", 0, 0)

    screen.drawTextBox(2, 13, 6, 6, frequency1, 0, 0)
    screen.drawTextBox(9, 13, 6, 6, frequency2, 0, 0)
    screen.drawTextBox(16, 13, 6, 6, frequency3, 0, 0)
    screen.drawTextBox(23, 13, 6, 6, frequency4, 0, 0)
end

function setC(r,g,b,a)
    if a==nil then a=255 end
    screen.setColor(r,g,b,a)
end