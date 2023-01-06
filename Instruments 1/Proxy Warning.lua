proxy_warning = false
audible_warning = false

function onTick()
    engage_range = property.getNumber("Engage Distance")
    override = input.getBool(1)

    --Get Distances
    distanceF = input.getNumber(1)
    distanceFL = input.getNumber(2)
    distanceFR = input.getNumber(3)

    distanceR = input.getNumber(4)
    distanceRL = input.getNumber(5)
    distanceRR = input.getNumber(6)

    distanceF = math.floor(distanceF)
    distanceFL = math.floor(distanceFL)
    distanceFR = math.floor(distanceFR)

    distanceR = math.floor(distanceR)
    distanceRL = math.floor(distanceRL)
    distanceRR = math.floor(distanceRR)

    if not override then
        if ((distanceF < engage_range) or (distanceFL < engage_range) or (distanceFR < engage_range) or (distanceR < engage_range) or (distanceRL < engage_range) or (distanceRR < engage_range)) then
            proxy_warning = true
        else
            proxy_warning = false
        end
        if ((distanceF < engage_range/2) or (distanceFL < engage_range/2) or (distanceFR < engage_range/2) or (distanceR < engage_range/2) or (distanceRL < engage_range/2) or (distanceRR < engage_range/2)) then
            audible_warning = true
        else
            audible_warning = false
        end
    end

    --Set Outputs
    output.setBool(1, audible_warning)
end

function onDraw()
    w = screen.getWidth()
    h = screen.getHeight()

    if not override then
        if ((distanceF < engage_range*2) or (distanceFL < engage_range*2) or (distanceFR < engage_range*2) or (distanceR < engage_range*2) or (distanceRL < engage_range*2) or (distanceRR < engage_range*2)) then
            --Draw Boat
            screen.setColor(0,255,0)
            screen.drawLine(w*0.38, h*0.22, w*0.38, h*0.78)
            screen.drawLine(w*0.62, h*0.22, w*0.62, h*0.78)
            
            screen.drawLine(w*0.38,h*0.22,w/2,h*0.1)
            screen.drawLine(w*0.62,h*0.22,w/2,h*0.1)
            
            screen.drawLine(w*0.38, h*0.78, w*0.38+2,h*0.82)
            screen.drawLine(w*0.62, h*0.78, w*0.62-2,h*0.82)
            screen.drawLine(w*0.38+2,h*0.82,w*0.62-2,h*0.82)

            --Draw Distances
            screen.setColor(0,255,0)
            screen.drawTextBox(w/2-8, 1, 16, 6, distanceF, 0, 0)
            screen.drawTextBox(1, h*0.25, 16, 6, distanceFL, 1, 0)
            screen.drawTextBox(w-17, h*0.25, 16, 6, distanceFR, -1, 0)

            screen.drawTextBox(w/2-8, h-13, 16, 6, distanceR, 0, 0)
            screen.drawTextBox(1, h*0.75, 16, 6, distanceRL, 1, 0)
            screen.drawTextBox(w-17, h*0.75, 16, 6, distanceRR, -1, 0)

            --Draw Exclamation Mark
            screen.setColor(255,0,0)
            if proxy_warning then
                screen.drawRectF(w/2-3, h*0.22, 6, h*0.4)
                screen.drawRectF(w/2-3, h*0.66, 6, 6)
            end
        end
    end
end