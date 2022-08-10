rotA = {}
rotP = {}
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
    
    if active_on then
        screen.drawCircle(w/2, h/2, 1480*counter*ring_size/120)
    end
    
    --Add Targets to Array
    if target1 then
        rotA[math.floor(pivot1*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot1*150)] = (1480*counter*ring_size/120)
    end
    if target2 then
        rotA[math.floor(pivot2*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot2*150)] = (1480*counter*ring_size/120)
    end
    if target3 then
        rotA[math.floor(pivot3*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot3*150)] = (1480*counter*ring_size/120)
    end
    if target4 then
        rotA[math.floor(pivot4*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot4*150)] = (1480*counter*ring_size/120)
    end
    if target5 then
        rotA[math.floor(pivot5*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot5*150)] = (1480*counter*ring_size/120)
    end
    if target6 then
        rotA[math.floor(pivot6*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot6*150)] = (1480*counter*ring_size/120)
    end
    if target7 then
        rotA[math.floor(pivot7*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot7*150)] = (1480*counter*ring_size/120)
    end
    if target8 then
        rotA[math.floor(pivot8*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot8*150)] = (1480*counter*ring_size/120)
    end
    if target9 then
        rotA[math.floor(pivot9*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot9*150)] = (1480*counter*ring_size/120)
    end
    if target10 then
        rotA[math.floor(pivot10*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot10*150)] = (1480*counter*ring_size/120)
    end
    if target11 then
        rotA[math.floor(pivot11*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot11*150)] = (1480*counter*ring_size/120)
    end
    if target12 then
        rotA[math.floor(pivot12*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot12*150)] = (1480*counter*ring_size/120)
    end
    if target13 then
        rotA[math.floor(pivot13*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot13*150)] = (1480*counter*ring_size/120)
    end
    if target14 then
        rotA[math.floor(pivot14*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot14*150)] = (1480*counter*ring_size/120)
    end
    if target15 then
        rotA[math.floor(pivot15*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot15*150)] = (1480*counter*ring_size/120)
    end
    if target16 then
        rotA[math.floor(pivot16*150)] = (1480*counter*ring_size/120)
        rotP[math.floor(pivot16*150)] = (1480*counter*ring_size/120)
    end

    if ping_sent then
    	rotA = {}
	end

    if not active_on then
        rotA = {}
    end

    if not off_button then
        rotP = {}
    end

    --Draw Targets Active
    for rotF, distance in pairs(rotA) do
        if distance > 0 then
            screen.setColor(255,0,0)
            screen.drawCircleF(h/2+distance*math.cos(rotF/25-(math.pi/2)),w/2+distance*math.sin(rotF/25-(math.pi/2)), 1)
        end
    end

    --Draw Targets Passive
    for rotFP, distanceP in pairs(rotP) do
        if distanceP > 0 then
            screen.setColor(255,255,0)
            screen.drawLine(w/2, h/2, h/2+distanceP*math.cos(rotFP/25-(math.pi/2)),w/2+distanceP*math.sin(rotFP/25-(math.pi/2)))
        end
    end
end