rotV = {}
sweep_angle = 0.5

function onTick()
    off_button = input.getBool(1)

    distance = input.getNumber(1)
    worldX = input.getNumber(2)
    worldY = input.getNumber(3)
    zoom = input.getNumber(4)
    rotation = input.getNumber(5) * 4
    rotation_Draw = input.getNumber(5)

    if off_button then
        if math.abs(rotation) >= math.abs(sweep_angle) - 0.01 then
            sweep_angle = -sweep_angle 
        end
    end
    output.setNumber(1, sweep_angle)
    output.setNumber(2, distance)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()

    x1 = w/2+(w/2-1)*math.cos(rotation_Draw * (math.pi*2)-(math.pi/2))*1.5

    --Draw Scanning Line
    screen.setColor(0,255,0)
    screen.drawLine(w/2, h/2, x1, 0)

    --Draw Objects
    if distance < 300 then
        rotV[rotation_Draw] = distance
    end

    if not off_button then
        rotV = {}
    end
    
    if rotation >= -sweep_angle + 0.02 then
        rotV = {}
    end

    for rotF, distance in pairs(rotV) do
        screen.setColor(255,255,0)
        rotL = rotF * (math.pi*2)
    	distance = (distance/300)*16
		x1 = math.sin(rotL) * distance + 16
        y1 = -math.cos(rotL) * distance + 16
        x2 = math.sin(rotL) * distance * 50 + 16
        y2 = -math.cos(rotL) * distance * 50 + 16
        screen.drawLine(x1, y1, x2, y2)
    end
    
    --Draw Blocker Triangles
    screen.setColor(0,0,0)
    screen.drawTriangleF(w/2, h/2, 0, 0, 0, h)
    screen.drawTriangleF(w/2, h/2, w+1, 0, w, h)
    screen.drawTriangleF(w/2, h/2, 0, h, w, h)

    --Draw Circle
    screen.setColor(0,255,0)
    screen.drawCircle(w/2-0.5, h/2-0.5, 15.5)

    --Draw LIDAR lines
    screen.setColor(0,255,0)
    screen.drawLine(w/2, h/2, 0, 0)
    screen.drawLine(w/2, h/2, w, 0)
end