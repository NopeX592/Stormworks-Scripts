rotV = {}
sweep_angle = 0.5

function onTick()
    off_button = input.getBool(1)

    distance = input.getNumber(1)
    worldX = input.getNumber(2)
    worldY = input.getNumber(3)
    zoom = input.getNumber(4)
    rotation = input.getNumber(5) * 4
    rotation_Draw = input.getNumber(5) * (math.pi*2)
    
    if off_button then
        if rotation == sweep_angle then
            sweep_angle = sweep_angle * -1
        end
    end
    output.setNumber(1, sweep_angle)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()

    x1 = w/2+(w/2-1)*math.cos(rotation_Draw-(math.pi/2))

    --Draw Map	
	screen.setMapColorOcean(14,46,48)
	screen.setMapColorShallows(24,68,72)
	screen.setMapColorLand(90,90,90)
	screen.setMapColorGrass(64,85,48)
	screen.setMapColorSand(100,93,41)
	screen.setMapColorSnow(200,200,200)
	screen.drawMap(worldX, worldY, zoom)

    --Draw Scanning Line
    screen.setColor(0,255,0)
    screen.drawLine(w/2, h/2, x1, 0)

    --Draw Objects
    if distance > 300 then
    	distance = ((distance/300)*h/2)-16
        rotV[rotation_Draw] = distance
    end

    if not off_button then
        rotV = {}
    end
    
    if rotation == -0.5 then
        rotV = {}
    end
    
    for rotF, distance in pairs(rotV) do
        screen.setColor(255,255,0)
        screen.drawRectF(w/2+(w/2-1)*math.cos(rotF-(math.pi/2)),distance,1,1)
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