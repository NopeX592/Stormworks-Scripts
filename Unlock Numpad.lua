but_s = 7
l_s = 5
b_s_n = 10
l_s_n = 5
b_d_l = 1
b_d_r = 26
b_d_t = 1
num_s_v = ""
isLocked = false
p_code = property.getText("Pass_Code")

function onTick() 
    inputX = input.getNumber(3)
    inputY = input.getNumber(4)
	isP = input.getBool(1)
    
    if not (isPBE or isPBD or isPB1 or isPB2 or isPB3 or isPB4 or isPB5 or isPB6 or isPB7 or isPB8 or isPB9 or isPB0) then
    	isLocked = false
    end
    
    isPB1 = isP and isPIB (inputX, inputY, 1, 9, but_s, but_s)
    isPB2 = isP and isPIB (inputX, inputY, 9, 9, but_s, but_s)
    isPB3 = isP and isPIB (inputX, inputY, 17, 9, but_s, but_s)
    isPBE = isP and isPIB (inputX, inputY, 24, 9, but_s, but_s)
    isPB4 = isP and isPIB (inputX, inputY, 1, 17, but_s, but_s)
    isPB5 = isP and isPIB (inputX, inputY, 9, 17, but_s, but_s)
    isPB6 = isP and isPIB (inputX, inputY, 17, 17, but_s, but_s)
    isPBD = isP and isPIB (inputX, inputY, 24, 17, but_s, but_s)
    isPB7 = isP and isPIB (inputX, inputY, 1, 25, but_s, but_s)
    isPB8 = isP and isPIB (inputX, inputY, 9, 25, but_s, but_s)
    isPB9 = isP and isPIB (inputX, inputY, 17, 25, but_s, but_s)
    isPB0 = isP and isPIB (inputX, inputY, 24, 25, but_s, but_s)
    
    if not isLocked then

	    if isPBE then
	    	if num_s_v == "" then
	    		output.setBool(1, false)
	    		num_s_v = ""
	    	else
				if num_s_v == p_code then
					output.setBool(1, true)
				end
	        end
	    end
	    if isPBD then
	        num_s_v = ""
	    end
	    
	    if string.len(num_s_v) < 4 then
		    if isPB1 then
		        num_s_v = num_s_v .. "1"
		    end
		    if isPB2 then        
		        num_s_v = num_s_v .. "2"
		    end
		    if isPB3 then
		        num_s_v = num_s_v .. "3"
		    end
		    if isPB4 then
		        num_s_v = num_s_v .. "4"
		    end
		    if isPB5 then
		        num_s_v = num_s_v .. "5"
		    end
		    if isPB6 then
		        num_s_v = num_s_v .. "6"
		    end
		    if isPB7 then
		        num_s_v = num_s_v .. "7"
		    end
		    if isPB8 then
		        num_s_v = num_s_v .. "8"
		    end
		    if isPB9 then
		        num_s_v = num_s_v .. "9"
		    end
		    if isPB0 then
		        num_s_v = num_s_v .. "0"
		    end
		end
	    isLocked = true
    end
end

function isPIB (x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function onDraw()
	ws=screen.getWidth()
	hs=screen.getHeight()
    b_d_l_n = 1
    b_d_t_n = 0

	if isLocked then
		setC(57,57,57)
		screen.drawRectF(0, 0, ws, but_s)
	end

	setC(57,57,57)
	screen.drawRectF(1,1,30,4)
	screen.drawRectF(0,8,23,24)
	screen.drawRectF(1,8,21,23)
	screen.drawRectF(21,24,11,8)
	screen.drawRectF(22,25,9,6)
	screen.drawRectF(24,8,7,15)
	screen.drawRectF(25,8,6,14)
    setC(255, 255, 255)
    screen.drawTextBox(24, 25, l_s_n, l_s_n, "0", b_d_l + 0, 0)
    screen.drawTextBox(1, 9, l_s_n, l_s_n, "1", b_d_l + 0, 0)
    screen.drawTextBox(9, 9, l_s_n, l_s_n, "2", b_d_l + 0, 0)
    screen.drawTextBox(17, 9, l_s_n, l_s_n, "3", b_d_l + 0, 0)
    screen.drawTextBox(1, 17, l_s_n, l_s_n, "4", b_d_l + 0, 0)
    screen.drawTextBox(9, 17, l_s_n, l_s_n, "5", b_d_l + 0, 0)
    screen.drawTextBox(17, 17, l_s_n, l_s_n, "6", b_d_l + 0, 0)
    screen.drawTextBox(1, 25, l_s_n, l_s_n, "7", b_d_l + 0, 0)
    screen.drawTextBox(9, 25, l_s_n, l_s_n, "8", b_d_l + 0, 0)
    screen.drawTextBox(17, 25, l_s_n, l_s_n, "9", b_d_l + 0, 0)
    setC(0, 255, 0)
    screen.drawTextBox(24, 9, l_s_n, l_s_n, "E", b_d_l + 0, 0)
    setC(255, 0, 0)
    screen.drawTextBox(24, 17, l_s_n, l_s_n, "D", b_d_l + 0, 0)
    if isPBE and num_s_v == p_code then
        setC(0, 255, 0)
		screen.drawRectF(0, 0, ws, but_s)
	elseif isPBE and num_s_v ~= p_code then
		setC(255, 0, 0)
		screen.drawRectF(0, 0, ws, but_s)
		setC(255, 255, 255)
		screen.drawTextBox(0, 0, ws, but_s, "ERROR", 0, 0)
    elseif isPBD then
        setC(255, 0, 0)
		screen.drawRectF(0, 0, ws, but_s)
	elseif num_s_v == "" then
		setC(255, 255, 255)
		screen.drawTextBox(0, 0, ws, but_s, "CODE", 0, 0)
	else
		setC(255, 255, 255)
	    screen.drawTextBox(l_s + 0.5, 1, l_s_n * 4, l_s_n, num_s_v, b_d_l + 0, 0)
	end
end

function setC(r,g,b,a)
	if a==nil then a=255 end
	screen.setColor(r,g,b,a)
end	