i3sliderv={x=4,y=14,w=7,h=17,v=0}
i5sliderv={x=21,y=14,w=7,h=17,v=0}

but_s = 7
l_s = 5
b_d_l = 1
b_d_r = 26
b_d_t = 1
isLocked = false

function onTick()
    isP1 = input.getBool(1)
    isP2 = input.getBool(2)

    in1X = input.getNumber(3)
    in1Y = input.getNumber(4)
    in2X = input.getNumber(5)
    in2Y = input.getNumber(6)

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
    
    if isP1 and isInRectO(i3sliderv,in1X,in1Y) then
    i3sliderv.v=((i3sliderv.y+i3sliderv.h)-in1Y)/i3sliderv.h
    elseif isP2 and isInRectO(i3sliderv,in2X,in2Y) then
    i3sliderv.v=((i3sliderv.y+i3sliderv.h)-in2Y)/i3sliderv.h
    end
    if i3sliderv.v<0 then
    i3sliderv.v=0
    elseif i3sliderv.v>1 then
    i3sliderv.v=1
    end
    output.setNumber(1,i3sliderv.v)
    
    if isP1 and isInRectO(i5sliderv,in1X,in1Y) then
    i5sliderv.v=((i5sliderv.y+i5sliderv.h)-in1Y)/i5sliderv.h
    elseif isP2 and isInRectO(i5sliderv,in2X,in2Y) then
    i5sliderv.v=((i5sliderv.y+i5sliderv.h)-in2Y)/i5sliderv.h
    end
    if i5sliderv.v<0 then
    i5sliderv.v=0
    elseif i5sliderv.v>1 then
    i5sliderv.v=1
    end
    output.setNumber(2,i5sliderv.v)
end

function isPIB(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
    t_s1 = property.getText("label_s1")
    t_s2 = property.getText("label_s2")
    setC(57,57,57)
    screen.drawRectF(0,8,32,24)
    setC(57,57,57)
    screen.drawRectF(1,9,30,22)
    
    setC(57,57,57)
    screen.drawRectF(0,0,32,7)
    setC(57,57,57)
    screen.drawRectF(1,1,30,5)
    
    setC(38,38,38)
    screen.drawRectF(4,14,7,17)
    setC(0,0,0)
    screen.drawRectF(i3sliderv.x,i3sliderv.y,i3sliderv.w,i3sliderv.h)
    setC(96,96,96)
    screen.drawRectF(i3sliderv.x,(1-i3sliderv.v)*i3sliderv.h+i3sliderv.y,i3sliderv.w,(i3sliderv.v)*i3sliderv.h)
    setC(38,38,38)
    screen.drawRect(i3sliderv.x,i3sliderv.y,i3sliderv.w,i3sliderv.h)
    
    setC(38,38,38)
    screen.drawRectF(21,14,7,17)
    setC(0,0,0)
    screen.drawRectF(i5sliderv.x,i5sliderv.y,i5sliderv.w,i5sliderv.h)
    setC(96,96,96)
    screen.drawRectF(i5sliderv.x,(1-i5sliderv.v)*i5sliderv.h+i5sliderv.y,i5sliderv.w,(i5sliderv.v)*i5sliderv.h)
    setC(38,38,38)
    screen.drawRect(i5sliderv.x,i5sliderv.y,i5sliderv.w,i5sliderv.h)

    setC(255, 255, 255)
    screen.drawTextBox(b_d_l, b_d_t, l_s, l_s, "<", 1, 0)
    screen.drawTextBox(b_d_r, b_d_t, l_s, l_s, ">", 1, 0)
    screen.drawTextBox(0, 9, l_s*3, l_s, t_s1, 0, 0)
    screen.drawTextBox(16, 9, l_s*3, l_s, t_s2, 0, 0)
end

function setC(r,g,b,a)
    if a==nil then a=255 end
    screen.setColor(r,g,b,a)
end

function isInRectO(o,px,py)
    return px>=o.x and px<=o.x+o.w and py>=o.y and py<=o.y+o.h
end