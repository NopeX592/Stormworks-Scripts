zoom = -0.5
x_off = 0
y_off = 0
circle_size = 3

cycles = 0

arr_WPX = {}
arr_WPY = {}

function onTick()
    isPressed = input.getBool(1)
    isPressingReset = input.getBool(4)
    isPressingBack = input.getBool(5)

    worldX = input.getNumber(7)
    worldY = input.getNumber(8)
    x_off = input.getNumber(9)
    y_off = input.getNumber(10)
    zoom = input.getNumber(11)
    worldWPX = input.getNumber(12)
    worldWPY = input.getNumber(13)

    --Reset
    if isPressingReset then
        cycles = 0
        arr_WPX[cycles] = worldX
        arr_WPY[cycles] = worldY
    end

    --Back
    if not (cycles == 0) then
        if isPressingBack then
            table.remove(arr_WPX, cycles)
            table.remove(arr_WPY, cycles)
            cycles = cycles - 1
        end
    end

    --Add Waypoints to Array
    if (worldWPX ~= oldX) or (worldWPY ~= oldY) then
        math.floor(worldWPX)
        arr_WPX[cycles] = worldWPX
        math.floor(worldWPY)
        arr_WPY[cycles] = worldWPY
        cycles = cycles + 1
    end

    --Set Old Waypoints Values
    oldX = worldWPX
    oldY = worldWPY

    --Set starting position
    arr_WPX[0] = worldX
    arr_WPY[0] = worldY

    --Calculate Heading
    if cycles >= 2 then
        first_wp = 1

        WPX_Trig = arr_WPX[first_wp]
        WPY_Trig = arr_WPY[first_wp]
        math.floor(WPX_Trig)
        math.floor(WPY_Trig)
        
        relativeX = WPX_Trig - worldX
        relativeY = WPY_Trig - worldY
        relativeHyp = math.sqrt(relativeX^2+relativeY^2)
        des_heading = math.asin(relativeX/relativeHyp)
        des_heading = des_heading * 180/math.pi
        if des_heading < 0 then
            des_heading = des_heading+360
        end
    end

    --Set Outputs
    output.setNumber(14, cycles)
    output.setNumber(15, des_heading)
    output.setNumber(16, WPX_Trig)
    output.setNumber(17, WPY_Trig)
end

function onDraw()
    --Draw Waypoint circles
    if not ((next(arr_WPX) == nil) or (next(arr_WPY) == nil)) then
        i = 0
        for i=0, cycles-1 do
            pixelWPX, pixelWPY = map.mapToScreen(x_off+worldX, y_off+worldY, zoom, 64, 64, arr_WPX[i], arr_WPY[i])
            if i == 0 then
                i = i + 1
            else
                i2 = i - 1
                --Draw Line
                pixelWPX2, pixelWPY2 = map.mapToScreen(x_off+worldX, y_off+worldY, zoom, 64, 64, arr_WPX[i2], arr_WPY[i2])
                screen.drawLine(pixelWPX, pixelWPY, pixelWPX2, pixelWPY2)
                --Draw Circle
                screen.setColor(200,20,20)
                screen.drawCircle(pixelWPX, pixelWPY, circle_size)
                i = i + 1
            end
        end
    end
end