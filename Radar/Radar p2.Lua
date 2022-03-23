rotV = {}

function onTick()
    target_found = false
    rotation = input.getNumber(7) * (math.pi*2)
    off_button = input.getBool(5)

    target1 = input.getBool(3)
    target2 = input.getBool(4)
    distance1 = input.getNumber(8)
    distance2 = input.getNumber(9)
    rangeRaw = input.getNumber(10)
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
    if target1 or target2 then
        rotV[math.floor(rotation*25)] = distance1*range
        rotV[math.floor(rotation*25)] = distance2*range
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