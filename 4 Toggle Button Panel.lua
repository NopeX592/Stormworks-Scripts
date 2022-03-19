but_s = 7
l_s = 5
b_d_l = 1
b_d_r = 26
b_d_t = 1
isLocked = false
i1Toggled = false
i1ToggledP = false

i4Toggled = false
i4ToggledP = false

i8Toggled = false
i8ToggledP = false

i9Toggled = false
i9ToggledP = false

i10Toggled = false
i10ToggledP = false

function onTick() 
    inputX = input.getNumber(3)
    inputY = input.getNumber(4)
    isP = input.getBool(1)
	output.setBool(1, false)
	output.setBool(2, false)


    if not (iPBl or iPBr) then
    	isLocked = false
    end
    
    iPBl = isP and isPIB(inputX, inputY, b_d_l, b_d_t, but_s, but_s)
    iPBr = isP and isPIB(inputX, inputY, b_d_r, b_d_t, but_s, but_s)
    
    if not isLocked then
		if iPBl then
			output.setBool(1, true)
		end
		if iPBr then
			output.setBool(2, true)
		end
	    isLocked = true
    end

    isP1 = input.getBool(1)
    isP2 = input.getBool(2)

    in1X = input.getNumber(3)
    in1Y = input.getNumber(4)
    in2X = input.getNumber(5)
    in2Y = input.getNumber(6)

    if (isP1 and isInRect(3,9,10,10,in1X,in1Y)) or (isP2 and isInRect(3,9,10,10,in2X,in2Y)) then
    i4ToggledP=true
    end
    if not (isP1 or isP2) and i4ToggledP then
    i4ToggledP = false
    i4Toggled = not i4Toggled
    end
    output.setBool(3, i4Toggled)

    if (isP1 and isInRect(19,9,10,10,in1X,in1Y)) or (isP2 and isInRect(19,9,10,10,in2X,in2Y)) then
    i8ToggledP=true
    end
    if not (isP1 or isP2) and i8ToggledP then
    i8ToggledP = false
    i8Toggled = not i8Toggled
    end
    output.setBool(4, i8Toggled)

    if (isP1 and isInRect(3,21,10,10,in1X,in1Y)) or (isP2 and isInRect(3,21,10,10,in2X,in2Y)) then
    i9ToggledP=true
    end
    if not (isP1 or isP2) and i9ToggledP then
    i9ToggledP = false
    i9Toggled = not i9Toggled
    end
    output.setBool(5, i9Toggled)

    if (isP1 and isInRect(19,21,10,10,in1X,in1Y)) or (isP2 and isInRect(19,21,10,10,in2X,in2Y)) then
    i10ToggledP=true
    end
    if not (isP1 or isP2) and i10ToggledP then
    i10ToggledP = false
    i10Toggled = not i10Toggled
    end
    output.setBool(6, i10Toggled)
end

function isPIB(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
    t_b1 = property.getText("label_b1")
    t_b2 = property.getText("label_b2")
    t_b3 = property.getText("label_b3")
    t_b4 = property.getText("label_b4")
    setC(57,57,57)
    screen.drawRectF(0,8,32,24)
    screen.drawRectF(1,9,30,22)
    screen.drawRectF(0,0,32,7)
    screen.drawRectF(1,1,30,5)
    
    setC(50,0,0)
    screen.drawRectF(3,9,10,10)
    screen.drawRectF(4,10,8,8)
    screen.drawRectF(19,9,10,10)
    screen.drawRectF(20,10,8,8)
    screen.drawRectF(3,21,10,10)
    screen.drawRectF(4,22,8,8)
    screen.drawRectF(19,21,10,10)
    screen.drawRectF(20,22,8,8)
    if i4Toggled then
    text=""
    end
    if i4Toggled then
    setC(96,0,0)
    screen.drawRectF(3, 9, 10, 10)
    end
    if i4Toggled then
    setC(96,96,96)
    else
    setC(96,96,96)
    end

    if i8Toggled then
    text=""
    end
    if i8Toggled then
    setC(96,0,0)
    screen.drawRectF(19, 9, 10, 10)
    end
    if i8Toggled then
    setC(96,96,96)
    else
    setC(96,96,96)
    end

    if i9Toggled then
    text=""
    end
    if i9Toggled then
    setC(96,0,0)
    screen.drawRectF(3, 21, 10, 10)
    end
    if i9Toggled then
    setC(96,96,96)
    else
    setC(96,96,96)
    end

    if i10Toggled then
    text=""
    end
    if i10Toggled then
    setC(96,0,0)
    screen.drawRectF(19, 21, 10, 10)
    end
    if i10Toggled then
    setC(96,96,96)
    else
    setC(96,96,96)
    end
    
    setC(255, 255, 255)
    screen.drawTextBox(4, 9, 10, 10, t_b1, 0, 0)
    screen.drawTextBox(20, 9, 10, 10, t_b2, 0, 0)
    screen.drawTextBox(4, 21, 10, 10, t_b3, 0, 0)
	screen.drawTextBox(20, 21, 10, 10, t_b4, 0, 0)
    screen.drawTextBox(b_d_l, b_d_t, l_s, l_s, "<", 1, 0)
	screen.drawTextBox(b_d_r, b_d_t, l_s, l_s, ">", 1, 0)
end

function setC(r,g,b,a)
	if a==nil then a=255 end
	screen.setColor(r,g,b,a)
end	

function isInRect(x,y,w,h,px,py)
    return px>=x and px<=x+w and py>=y and py<=y+h
end