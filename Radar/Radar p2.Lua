rotV = {}

function onTick()

    
    --Radar 2
    target1_1 = input.getBool(1)
    target1_2 = input.getBool(2)
    target1_3 = input.getBool(3)
    target1_4 = input.getBool(4)
    target1_5 = input.getBool(5)
    target1_6 = input.getBool(6)
    target1_7 = input.getBool(7)
    target1_8 = input.getBool(8)

    distance1_1 = input.getNumber(1)
    distance1_2 = input.getNumber(2)
    distance1_3 = input.getNumber(3)
    distance1_4 = input.getNumber(4)
    distance1_5 = input.getNumber(5)
    distance1_6 = input.getNumber(6)
    distance1_7 = input.getNumber(7)
    distance1_8 = input.getNumber(8)

    --Radar 2
    target2_1 = input.getBool(9)
    target2_2 = input.getBool(10)
    target2_3 = input.getBool(11)
    target2_4 = input.getBool(12)
    target2_5 = input.getBool(13)
    target2_6 = input.getBool(14)
    target2_7 = input.getBool(15)
    target2_8 = input.getBool(16)

    distance2_1 = input.getNumber(9)
    distance2_2 = input.getNumber(10)
    distance2_3 = input.getNumber(11)
    distance2_4 = input.getNumber(12)
    distance2_5 = input.getNumber(13)
    distance2_6 = input.getNumber(14)
    distance2_7 = input.getNumber(15)
    distance2_8 = input.getNumber(16)

    off_button = input.getBool(17)

    rangeRaw = input.getNumber(17)
    rotation = input.getNumber(18) * (math.pi*2)

    --Determine Target Found
    if ((target1_1 or target1_2 or target1_3 or target1_4 or target1_5 or target1_6 or target1_7 or target1_8) or (target2_1 or target2_2 or target2_3 or target2_4 or target2_5 or target2_6 or target2_7 or target2_8)) then
        target_found = true
    else
        target_found = false
    end
    output.setBool(1, target_found)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()

    x1 = w/2+(w/2-1)*math.cos(rotation-(math.pi/2))
    y1 = h/2+(h/2-1)*math.sin(rotation-(math.pi/2))

    --Draw Scanning Lines
    screen.setColor(0,255,0)
    screen.drawLine(w/2, h/2, x1, y1)

    screen.setColor(0,255,0,100)
    x1 = w/2+(w/2-1)*math.cos(rotation-(math.pi/2+0.1))
    y1 = h/2+(h/2-1)*math.sin(rotation-(math.pi/2+0.1))
    screen.drawLine(w/2, h/2, x1, y1)

    screen.setColor(0,255,0,75)
    x1 = w/2+(w/2-1)*math.cos(rotation-(math.pi/2+0.175))
    y1 = h/2+(h/2-1)*math.sin(rotation-(math.pi/2+0.175))
    screen.drawLine(w/2, h/2, x1, y1)

    screen.setColor(0,255,0,50)
    x1 = w/2+(w/2-1)*math.cos(rotation-(math.pi/2+0.275))
    y1 = h/2+(h/2-1)*math.sin(rotation-(math.pi/2+0.275))
    screen.drawLine(w/2, h/2, x1, y1)

    screen.setColor(0,255,0,25)
    x1 = w/2+(w/2-1)*math.cos(rotation-(math.pi/2+0.375))
    y1 = h/2+(h/2-1)*math.sin(rotation-(math.pi/2+0.375))
    screen.drawLine(w/2, h/2, x1, y1)

    --Draw targets
    range = (h/2)/rangeRaw
    --Add Radar 1 to Array
    if target1_1 then
        rotV[math.floor(rotation*25)] = distance1_1*range
    end
    if target1_2 then
        rotV[math.floor(rotation*25)] = distance1_2*range
    end
    if target1_3 then
        rotV[math.floor(rotation*25)] = distance1_3*range
    end
    if target1_4 then
        rotV[math.floor(rotation*25)] = distance1_4*range
    end
    if target1_5 then
        rotV[math.floor(rotation*25)] = distance1_5*range
    end
    if target1_6 then
        rotV[math.floor(rotation*25)] = distance1_6*range
    end
    if target1_7 then
        rotV[math.floor(rotation*25)] = distance1_7*range
    end
    if target1_8 then
        rotV[math.floor(rotation*25)] = distance1_8*range
    end

    --Add Radar 2 to Array
    if target2_1 then
        rotV[math.floor(rotation*25)] = distance2_1*range
    end
    if target2_2 then
        rotV[math.floor(rotation*25)] = distance2_2*range
    end
    if target2_3 then
        rotV[math.floor(rotation*25)] = distance2_3*range
    end
    if target2_4 then
        rotV[math.floor(rotation*25)] = distance2_4*range
    end
    if target2_5 then
        rotV[math.floor(rotation*25)] = distance2_5*range
    end
    if target2_6 then
        rotV[math.floor(rotation*25)] = distance2_6*range
    end
    if target2_7 then
        rotV[math.floor(rotation*25)] = distance2_7*range
    end
    if target2_8 then
        rotV[math.floor(rotation*25)] = distance2_8*range
    end

    if not off_button then
        rotV = {}
    end

    if x1 > 1.1 and x1 < 1.2 then
        rotV = {}
    end

    for rotF, distance in pairs(rotV) do
        if distance > 0 then
            screen.setColor(255,0,0,50)
            screen.drawCircleF(h/2+distance*math.cos(rotF/25-(math.pi/2)),w/2+distance*math.sin(rotF/25-(math.pi/2)), 1)
        end
    end
end