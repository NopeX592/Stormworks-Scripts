rotV = {}
counter = 0
ring_size = 0

function onTick()
    --Sonar Target found
    target1 = input.getBool(1)
    target2 = input.getBool(2)
    target3 = input.getBool(3)
    target4 = input.getBool(4)
    target5 = input.getBool(5)
    target6 = input.getBool(6)
    target7 = input.getBool(7)
    target8 = input.getBool(8)
    target9 = input.getBool(9)
    target10 = input.getBool(10)
    target11 = input.getBool(11)
    target12 = input.getBool(12)
    target13 = input.getBool(13)
    target14 = input.getBool(14)
    target15 = input.getBool(15)
    target16 = input.getBool(16)

    --Sonar Target Pivot
    pivot1 = input.getNumber(1)
    pivot2 = input.getNumber(2)
    pivot3 = input.getNumber(3)
    pivot4 = input.getNumber(4)
    pivot5 = input.getNumber(5)
    pivot6 = input.getNumber(6)
    pivot7 = input.getNumber(7)
    pivot8 = input.getNumber(8)
    pivot9 = input.getNumber(9)
    pivot10 = input.getNumber(10)
    pivot11 = input.getNumber(11)
    pivot12 = input.getNumber(12)
    pivot13 = input.getNumber(13)
    pivot14 = input.getNumber(14)
    pivot15 = input.getNumber(15)
    pivot16 = input.getNumber(16)

    --Other Inputs
    off_button = input.getBool(17)
    active_on = input.getBool(18)
    ping_sent = input.getBool(19)
    rangeRaw = input.getNumber(17)

    --Determine Target Distance
    ping_interval = rangeRaw*120/1480
    if active_on then
        counter = counter + 1 
    end
    if counter > ping_interval then
        counter = 0
    end

    output.setNumber(1,(1480*counter*ring_size/120))
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
    range = (h/2)/rangeRaw

    --Draw Ping Circle
    screen.setColor(0,255,0)
    ring_size = (w-2)/rangeRaw
    screen.drawCircle(w/2, h/2, 1480*counter*ring_size/120)

    --Draw Targets
    --Add Targets to Array
    if target1 then
        rotV[math.floor(pivot1*25)] = (1480*counter*ring_size/120)
    end

    for rotF, distance in pairs(rotV) do
        if distance > 0 then
            screen.setColor(255,0,0)
            screen.drawCircleF(h/2+distance*math.cos(rotF/25-(math.pi/2)),w/2+distance*math.sin(rotF/25-(math.pi/2)), 1)
        end
    end
end