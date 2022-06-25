relativeX = 0
relativeY = 0
WP_reached = false

function onTick()
    completion_radius = property.getNumber("Completion Radius")

    worldX = input.getNumber(1)
    worldY = input.getNumber(2) 
    cycles = input.getNumber(3)
    WPX_Next = input.getNumber(4)
    WPY_Next = input.getNumber(5)

    relativeX = worldX - WPX_Next 
    relativeY = worldY - WPY_Next

    relativeX = math.abs(relativeX)
    relativeY = math.abs(relativeY)

    if ((relativeX < completion_radius) and (relativeY < completion_radius)) then
        WP_reached = true
        relativeX = 0
        relativeY = 0
    else
        WP_reached = false
    end

    --Set Outputs
    output.setBool(1, WP_reached)
    output.setNumber(21, relativeX)
    output.setNumber(22, relativeY)
end