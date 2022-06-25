WP_reached = false
function onTick()
    completion_radius = property.getNumber("Completion Radius")

    worldX = input.getNumber(1)
    worldY = input.getNumber(2)
    WPX_Next = input.getNumber(16)
    WPY_Next = input.getNumber(17)
    cycles = input.getNumber(14)

    relativeX = WPX_Next - worldX
    relativeY = WPY_Next - worldY

    relativeX = math.abs(relativeX)
    relativeY = math.abs(relativeY)

    if ((relativeX < completion_radius) AND (relativeY < completion_radius)) then
        WP_reached = true
    else
        WP_reached = false
    end

    --Set Outputs
    output.setBool(1, WP_reached)
end