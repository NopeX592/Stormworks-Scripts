zoom = -0.5
x_off = 0
y_off = 0
circle_size = 3
dist_WP = 1000000

cycle = 0

WP_reached = false
isLocked = false

arr_WPX = {}
arr_WPY = {}

function onTick()
    compl_radius = property.getNumber("Completion Radius")

    isPressingReset = input.getBool(4)
    isPressingBack = input.getBool(5)
    isStarting = input.getBool(6)

    worldX = input.getNumber(7)
    worldY = input.getNumber(8)
    x_off = input.getNumber(9)
    y_off = input.getNumber(10)
    zoom = input.getNumber(11)
    worldWPX = input.getNumber(12)
    worldWPY = input.getNumber(13)

    --External Waypoints
    keyPulse = input.getBool(8)
    keyWPX = input.getNumber(14)
    keyWPY = input.getNumber(15)

    locPulse = input.getBool(9)
    locWPX = input.getNumber(16)
    locWPY = input.getNumber(17)

    --Reset
    if isPressingReset then
        WP_reached = false
        cycle = 0
        arr_WPX = {}
        arr_WPY = {}
        arr_WPX[0] = worldX
        arr_WPY[0] = worldY
    end

    --Back
    if not (cycle < 2) then
        if isPressingBack then
            table.remove(arr_WPX, cycle)
            table.remove(arr_WPY, cycle)
            cycle = cycle - 1
        end
    end

    --Add Waypoints to Array
    if (worldWPX ~= oldX) or (worldWPY ~= oldY) then
        math.floor(worldWPX)
        arr_WPX[cycle] = worldWPX
        math.floor(worldWPY)
        arr_WPY[cycle] = worldWPY
        cycle = cycle + 1
    end
    --Set Old Waypoints Values
    oldX = worldWPX
    oldY = worldWPY

    if keyPulse then
        math.floor(keyWPX)
        arr_WPX[cycle] = keyWPX
        math.floor(keyWPY)
        arr_WPY[cycle] = keyWPY
        cycle = cycle + 1
    end

    if locPulse then
        math.floor(locWPX)
        arr_WPX[cycle] = locWPX
        math.floor(locWPY)
        arr_WPY[cycle] = locWPY
        cycle = cycle + 1
    end

    --Set starting position
    arr_WPX[0] = worldX
    arr_WPY[0] = worldY

    if cycle == 0 then
        worldWPX = worldX
        worldWPY = worldY
        output.setNumber(12, worldWPX)
        output.setNumber(13, worldWPY)
    end
    
    --Calculate Relative Position
    if cycle >= 2 then
        first_wp = 1

        WPX_Trig = arr_WPX[first_wp]
        WPY_Trig = arr_WPY[first_wp]
        math.abs(WPX_Trig)
        math.abs(WPY_Trig)
        
        relX = WPX_Trig - worldX
        relY = WPY_Trig - worldY

        dist_WP = relX^2+relY^2
        dist_WP = math.sqrt(dist_WP)
    else
        relX = 0 - worldX
        relY = 0 - worldY
    end

    --Check Waypoint Completion
    if isStarting then
        if dist_WP < compl_radius then
            WP_reached = true
            table.remove(arr_WPX, 1)
            table.remove(arr_WPY, 1)
            cycle = cycle - 1
        else
            WP_reached = false
        end
    end
    
    if cycle < 0 then
        cycle = 1
    end

    --Set Outputs
    output.setNumber(15, relX)
    output.setNumber(16, relY)

    output.setBool(1, WP_reached)
    output.setNumber(2, cycle)
end

function onDraw()
    --Draw Waypoints
    if cycle >= 1 then
        i = 0
        for i=0, cycle-1 do
            pixWPX, pixWPY = map.mapToScreen(x_off+worldX, y_off+worldY, zoom, 64, 64, arr_WPX[i], arr_WPY[i])
            if i == 0 then
                i = i + 1
            else
                i2 = i - 1
                --Line
                pixWPX2, pixWPY2 = map.mapToScreen(x_off+worldX, y_off+worldY, zoom, 64, 64, arr_WPX[i2], arr_WPY[i2])
                screen.drawLine(pixWPX, pixWPY, pixWPX2, pixWPY2)
                --Circle
                screen.setColor(200,20,20)
                screen.drawCircle(pixWPX, pixWPY, circle_size)
                i = i + 1
            end
        end
    end
end