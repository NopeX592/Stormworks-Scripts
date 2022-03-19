

i1Toggled = false

i2Toggled = false

i3Toggled = false

i4Toggled = false

function onTick()
isP1 = input.getBool(1)
isP2 = input.getBool(2)

in1X = input.getNumber(3)
in1Y = input.getNumber(4)
in2X = input.getNumber(5)
in2Y = input.getNumber(6)

if (isP1 and isInRect(0,0,16,11,in1X,in1Y)) or (isP2 and isInRect(0,0,16,11,in2X,in2Y)) then
i1Toggled=true
else
i1Toggled=false
end
output.setBool(1, i1Toggled)

if (isP1 and isInRect(16,0,16,11,in1X,in1Y)) or (isP2 and isInRect(16,0,16,11,in2X,in2Y)) then
i2Toggled=true
else
i2Toggled=false
end
output.setBool(1, i2Toggled)

if (isP1 and isInRect(0,21,16,11,in1X,in1Y)) or (isP2 and isInRect(0,21,16,11,in2X,in2Y)) then
i3Toggled=true
else
i3Toggled=false
end
output.setBool(1, i3Toggled)

if (isP1 and isInRect(16,21,16,11,in1X,in1Y)) or (isP2 and isInRect(16,21,16,11,in2X,in2Y)) then
i4Toggled=true
else
i4Toggled=false
end
output.setBool(1, i4Toggled)

end

function onDraw()

setC(79,3,3)
screen.drawRectF(0,0,16,11)
setC(0,0,0)
screen.drawRectF(0,0,16,11)text="▲"
if i1Toggled then
text="▲"
end
if i1Toggled then
setC(19,96,0)
screen.drawRectF(0, 0, 16, 11)
end
if i1Toggled then
setC(96,96,96)
else
setC(96,96,96)
end
screen.drawTextBox(0, 0, 16, 11, text, 0, 0)

setC(79,3,3)
screen.drawRectF(16,0,16,11)
setC(0,0,0)
screen.drawRectF(16,0,16,11)text="▲"
if i2Toggled then
text="▲"
end
if i2Toggled then
setC(19,96,0)
screen.drawRectF(16, 0, 16, 11)
end
if i2Toggled then
setC(96,96,96)
else
setC(96,96,96)
end
screen.drawTextBox(16, 0, 16, 11, text, 0, 0)

setC(79,3,3)
screen.drawRectF(0,21,16,11)
setC(0,0,0)
screen.drawRectF(0,21,16,11)text="⯆"
if i3Toggled then
text="⯆"
end
if i3Toggled then
setC(96,0,0)
screen.drawRectF(0, 21, 16, 11)
end
if i3Toggled then
setC(96,96,96)
else
setC(96,96,96)
end
screen.drawTextBox(0, 21, 16, 11, text, 0, 0)

setC(79,3,3)
screen.drawRectF(16,21,16,11)
setC(0,0,0)
screen.drawRectF(16,21,16,11)text="⯆"
if i4Toggled then
text="⯆"
end
if i4Toggled then
setC(96,1,0)
screen.drawRectF(16, 21, 16, 11)
end
if i4Toggled then
setC(96,96,96)
else
setC(96,96,96)
end
screen.drawTextBox(16, 21, 16, 11, text, 0, 0)

setC(0,0,0)
screen.drawRectF(0,11,16,10)
setC(0,0,0)
screen.drawRectF(0,11,16,10)
setC(96,96,96)
screen.drawTextBox(0, 11, 16, 10, "ABC", 0, 0)

setC(0,0,0)
screen.drawRectF(16,11,16,10)
setC(0,0,0)
screen.drawRectF(16,11,16,10)
setC(96,96,96)
screen.drawTextBox(16, 11, 16, 10, "ABC", 0, 0)
end

function setC(r,g,b,a)
if a==nil then a=255 end
screen.setColor(r,g,b,a)
end

function isInRect(x,y,w,h,px,py)
return px>=x and px<=x+w and py>=y and py<=y+h
end