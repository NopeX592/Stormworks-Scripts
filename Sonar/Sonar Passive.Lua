X={}

function onTick()
    --Other Inputs
    off_button = input.getBool(17)
    rangeRaw = input.getNumber(17)

    --Target found
    if off_button then
        for i=1, 16 do
            --Get Pivot if target found
            if input.getBool(i) then
                X[i]=input.getNumber(i*2-1)*math.pi*2
            elseif not input.getBool(i) and X[i]~=nil then
                X[i]=nil
            end
        end
    end
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
    range = (h/2)/rangeRaw

    screen.setColor(255,255,0)
    --Draw Ping Lines
    for i=1, 16 do
        if X[i]~=nil then
            screen.drawLine(w/2,h/2,w/2-math.sin(X[i]),h/2-math.cos(X[i]))
        end
    end
end