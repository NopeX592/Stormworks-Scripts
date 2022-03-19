but_s = 7
l_s = 5
b_d_l = 1
b_d_r = 26
b_d_t = 1
isLocked = false

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
end

function isPIB(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	setC(255, 255, 255)
	screen.drawTextBox(b_d_l, b_d_t, l_s, l_s, "<", 1, 0)
	screen.drawTextBox(b_d_r, b_d_t, l_s, l_s, ">", 1, 0)
end

function setC(r,g,b,a)
	if a==nil then a=255 end
	screen.setColor(r,g,b,a)
end	