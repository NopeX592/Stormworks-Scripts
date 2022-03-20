function onTick()
    i7Val=input.getNumber(1)
    i8Val=input.getNumber(2)
    shift=input.getNumber(3)
    i7Max=input.getNumber(4)
    i8Max=input.getNumber(5)

    label_1 = property.getText("Dial 1 Label")
    label_2 = property.getText("Dial 2 Label")
end

function onDraw()
    setC(12,12,12)
    screen.drawCircleF(8+shift,25,7)
    screen.drawCircleF(24+shift,25,7)
    setC(0,0,0)
    screen.drawRectF(0+shift,7,16,8)
    screen.drawRectF(0+shift,7,16,8)
    screen.drawRectF(17+shift,7,15,8)
    screen.drawRectF(17+shift,7,15,8)

    setC(96,96,96)
    p=rotatePoint(8+shift,25,math.pi*1.5*(i7Val/i7Max),15+shift,25)screen.drawLine(8+shift,25,p.x,p.y)
	p=rotatePoint(24+shift,25,math.pi*1.5*(i8Val/i8Max),31+shift,25)screen.drawLine(24+shift,25,p.x,p.y)
    screen.drawTextBox(0+shift, 7, 16, 8, label_1, 0, 0)
    screen.drawTextBox(17+shift, 7, 15, 8, label_2, 0, 0)
end

function setC(r,g,b,a)
    if a==nil then a=255 end
    screen.setColor(r,g,b,a)
end

function rotatePoint(cx,cy,angle,px,py)
    s=math.sin(angle)
    c=math.cos(angle)
    px=px-cx
    py=py-cy
    xnew=px*c-py*s
    ynew=px*s+py*c
    px=xnew+cx
    py=ynew+cy
    return {x=px,y=py}
end

