zoom = -0.5
x_off = 0
y_off = 0
circle_size = 3

cycles = 0

WP_reached = false

arr_WPX = {}
arr_WPY = {}

function onTick()
    completion_radius = property.getNumber("Completion Radius")

    isPressed = input.getBool(1)
    isPressingReset = input.getBool(4)
    isPressingBack = input.getBool(5)
    isCompleted = input.getBool(6)

    worldX = input.getNumber(7)
    worldY = input.getNumber(8)
    x_off = input.getNumber(9)
    y_off = input.getNumber(10)
    zoom = input.getNumber(11)
    worldWPX = input.getNumber(12)
    worldWPY = input.getNumber(13)
    distance_WP = input.getNumber(14)

    --Reset
    if isPressingReset then
        WP_reached = false
        cycles = 0
        arr_WPX = {}
        arr_WPY = {}
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

    --Check Waypoint Completion and Remove Waypoints from Array
    if distance_WP < completion_radius then
        WP_reached = true
        table.remove(arr_WPX, 1)
        table.remove(arr_WPY, 1)
        cycles = cycles - 1
    else
        WP_reached = false
    end

    --Calculate Relative Position
    if cycles >= 2 then
        first_wp = 1

        WPX_Trig = arr_WPX[first_wp]
        WPY_Trig = arr_WPY[first_wp]
        math.floor(WPX_Trig)
        math.floor(WPY_Trig)
        
        relativeX = WPX_Trig - worldX
        relativeY = WPY_Trig - worldY
    else
        relativeX = 0 - worldX
        relativeY = 0 - worldY
    end

    --Set Outputs
    output.setNumber(14, cycles)
    output.setNumber(15, relativeX)
    output.setNumber(16, relativeY)
    output.setNumber(17, WPX_Trig)
    output.setNumber(18, WPY_Trig)

    output.setBool(1, WP_reached)
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