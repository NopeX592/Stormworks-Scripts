X={}
detection_time={}

so_sound = 1480
counter = 0

send_ping = false

function onTick()
    --Other Inputs
    off_button = input.getBool(17)
    active_on = input.getBool(18)
    ping_sent = input.getBool(19)
    rangeRaw = input.getNumber(17)

    ping_delay = ((rangeRaw/so_sound)*2)*60
    
    if off_button and active_on then
        --Ping Counter
        counter = counter + 1
        if counter > ping_delay then
            counter = 0
            send_ping = true
        else
            send_ping = false
        end
        --Target found
        for i=1, 16 do
            --Get Pivot if target found
            if input.getBool(i) then
                X[i]=input.getNumber(i*2-1)*math.pi*2
                --Add Detection Timing to Array
                detection_time[i] = counter
            elseif not input.getBool(i) and X[i]~=nil then
                X[i]=nil
            end
        end
    end

    --Set Outputs
    output.setBool(1,send_ping)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
    scale = (w-2)/rangeRaw

    if off_button and active_on then
        screen.setColor(0,255,0)
        screen.drawCircle(w/2, h/2, 1480*counter*scale/120)

        screen.setColor(255,0,0)
        for i = 1, 16 do
            if X[i]~=nil then
                --Calculate Distance
                distance = 1480*detection_time[1]/120
			    draw_pos = distance*scale
                --Draw Target
                screen.drawCircleF(draw_pos*math.cos(X[i]-1.57)+w/2, draw_pos*math.sin(X[i]-1.57)+w/2,0.5)
            end
        end
    end
end