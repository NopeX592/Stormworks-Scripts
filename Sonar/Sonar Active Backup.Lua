rotA = {}
rotP = {}
count = 0
sweep_count = 0
ring_s = 0

function onTick()
    --Sonar tar found
    tar1 = input.getBool(1)
    tar2 = input.getBool(2)
    tar3 = input.getBool(3)
    tar4 = input.getBool(4)
    tar5 = input.getBool(5)
    tar6 = input.getBool(6)
    tar7 = input.getBool(7)
    tar8 = input.getBool(8)
    tar9 = input.getBool(9)
    tar10 = input.getBool(10)
    tar11 = input.getBool(11)
    tar12 = input.getBool(12)
    tar13 = input.getBool(13)
    tar14 = input.getBool(14)
    tar15 = input.getBool(15)
    tar16 = input.getBool(16)

    --Sonar tar piv
    piv1 = input.getNumber(1)
    piv2 = input.getNumber(2)
    piv3 = input.getNumber(3)
    piv4 = input.getNumber(4)
    piv5 = input.getNumber(5)
    piv6 = input.getNumber(6)
    piv7 = input.getNumber(7)
    piv8 = input.getNumber(8)
    piv9 = input.getNumber(9)
    piv10 = input.getNumber(10)
    piv11 = input.getNumber(11)
    piv12 = input.getNumber(12)
    piv13 = input.getNumber(13)
    piv14 = input.getNumber(14)
    piv15 = input.getNumber(15)
    piv16 = input.getNumber(16)

    --Other Inputs
    off_button = input.getBool(17)
    active_on = input.getBool(18)
    ping_sent = input.getBool(19)
    rangeRaw = input.getNumber(17)

    --Determine tar Distance
    ping_interval = rangeRaw*120/1480
    if active_on then
        count = count + 1 
    end
    if count > ping_interval then
        count = 0
    end

    output.setNumber(1,(1480*count*ring_s/120))
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
    range = (h/2)/rangeRaw

    --Draw Ping Circle
    screen.setColor(0,255,0)
    ring_s = (w-2)/rangeRaw
    
    if active_on then
        screen.drawCircle(w/2, h/2, 1480*count*ring_s/120)
    end
    
    --Add tars to Array
    if tar1 then
        rotA[math.floor(piv1*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv1*150)] = (1480*count*ring_s/120)
    end
    if tar2 then
        rotA[math.floor(piv2*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv2*150)] = (1480*count*ring_s/120)
    end
    if tar3 then
        rotA[math.floor(piv3*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv3*150)] = (1480*count*ring_s/120)
    end
    if tar4 then
        rotA[math.floor(piv4*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv4*150)] = (1480*count*ring_s/120)
    end
    if tar5 then
        rotA[math.floor(piv5*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv5*150)] = (1480*count*ring_s/120)
    end
    if tar6 then
        rotA[math.floor(piv6*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv6*150)] = (1480*count*ring_s/120)
    end
    if tar7 then
        rotA[math.floor(piv7*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv7*150)] = (1480*count*ring_s/120)
    end
    if tar8 then
        rotA[math.floor(piv8*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv8*150)] = (1480*count*ring_s/120)
    end
    if tar9 then
        rotA[math.floor(piv9*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv9*150)] = (1480*count*ring_s/120)
    end
    if tar10 then
        rotA[math.floor(piv10*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv10*150)] = (1480*count*ring_s/120)
    end
    if tar11 then
        rotA[math.floor(piv11*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv11*150)] = (1480*count*ring_s/120)
    end
    if tar12 then
        rotA[math.floor(piv12*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv12*150)] = (1480*count*ring_s/120)
    end
    if tar13 then
        rotA[math.floor(piv13*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv13*150)] = (1480*count*ring_s/120)
    end
    if tar14 then
        rotA[math.floor(piv14*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv14*150)] = (1480*count*ring_s/120)
    end
    if tar15 then
        rotA[math.floor(piv15*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv15*150)] = (1480*count*ring_s/120)
    end
    if tar16 then
        rotA[math.floor(piv16*150)] = (1480*count*ring_s/120)
        rotP[math.floor(piv16*150)] = (1480*count*ring_s/120)
    end

    if ping_sent then
    	rotA = {}
	end

    if not active_on then
        rotA = {}

        --Draw tars Passive
        for rotFP, distanceP in pairs(rotP) do
            if distanceP > 0 then
                screen.setColor(255,255,0)
                screen.drawLine(w/2, h/2, h/2+distanceP*math.cos(rotFP/25-(math.pi/2)),w/2+distanceP*math.sin(rotFP/25-(math.pi/2)))
            end
        end
        --Clear Passive Screen
        sweep_count = sweep_count + 0.5
        if sweep_count > 60 then
            rotP = {}
            sweep_count = 0
        end
    end

    if not off_button then
        rotP = {}
    end
    
    --Draw Circle
    screen.setColor(0,255,0)
    screen.drawCircle(w/2-0.5, h/2-0.5, 15.5)
    screen.setColor(0,255,0,75)
    screen.drawCircle(w/2-0.5, h/2-0.5, 10.5)
    screen.drawCircle(w/2-0.5, h/2-0.5, 5)

    --Draw tars Active
    for rotF, distance in pairs(rotA) do
        if distance > 0 then
            screen.setColor(255,0,0)
            screen.drawCircleF(h/2+distance*math.cos(rotF/25-(math.pi/2)),w/2+distance*math.sin(rotF/25-(math.pi/2)), 1)
        end
    end
end