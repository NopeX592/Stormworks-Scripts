function round (num, numdec)
    local multi = 10^(numdec or 0)
    return math.floor(num * multi + 0.5) / multi
end

function onTick()
    heading = input.getNumber(1)
    tilt_f = (input.getNumber(5)*10)*90
    tilt_l = (input.getNumber(6)*10)*90
    altitude = input.getNumber(4)
    speed = input.getNumber(5)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
    cw = w-48
    ch = h-24
    ch_b = ch+(h/4)

    roll = math.rad(90 - tilt_l)

    rad = w+h
    small_rad = (w+h)/11
    small_rad_in = small_rad-4
    small_rad_tri = small_rad_in -2

    left_tri = math.rad(95 - tilt_l)
    right_tri = math.rad(85 - tilt_l)


	roll_linel45 = math.rad(45)
	roll_linel30 = math.rad(60)
    roll_linel15 = math.rad(75)
    roll_line = math.rad(90)
    roll_liner15 = math.rad(105)
    roll_liner30 = math.rad(120)
    roll_liner45 = math.rad(135)

    screen.setColor(255,255,255)--roll indicator
    x1r = cw+small_rad*math.cos(roll_line)
    y1r = ch_b+small_rad*math.sin(roll_line)
    x2r = cw+small_rad_in*math.cos(roll_line)
    y2r = ch_b+small_rad_in*math.sin(roll_line)

    x1rl15 = cw+small_rad*math.cos(roll_linel15)
    y1rl15 = ch_b+small_rad*math.sin(roll_linel15)
    x2rl15 = cw+small_rad_in*math.cos(roll_linel15)
    y2rl15 = ch_b+small_rad_in*math.sin(roll_linel15)

    x1rl30 = cw+small_rad*math.cos(roll_linel30)
    y1rl30 = ch_b+small_rad*math.sin(roll_linel30)
    x2rl30 = cw+small_rad_in*math.cos(roll_linel30)
    y2rl30 = ch_b+small_rad_in*math.sin(roll_linel30)

    x1rl45 = cw+small_rad*math.cos(roll_linel45)
    y1rl45 = ch_b+small_rad*math.sin(roll_linel45)
    x2rl45 = cw+small_rad_in*math.cos(roll_linel45)
    y2rl45 = ch_b+small_rad_in*math.sin(roll_linel45)

    x1rr15 = cw+small_rad*math.cos(roll_liner15)
    y1rr15 = ch_b+small_rad*math.sin(roll_liner15)
    x2rr15 = cw+small_rad_in*math.cos(roll_liner15)
    y2rr15 = ch_b+small_rad_in*math.sin(roll_liner15)

    x1rr30 = cw+small_rad*math.cos(roll_liner30)
    y1rr30 = ch_b+small_rad*math.sin(roll_liner30)
    x2rr30 = cw+small_rad_in*math.cos(roll_liner30)
    y2rr30 = ch_b+small_rad_in*math.sin(roll_liner30)

    x1rr45 = cw+small_rad*math.cos(roll_liner45)
    y1rr45 = ch_b+small_rad*math.sin(roll_liner45)
    x2rr45 = cw+small_rad_in*math.cos(roll_liner45)
    y2rr45 = ch_b+small_rad_in*math.sin(roll_liner45)

	screen.setColor(255,255,255)
    screen.drawLine(x1rl45, y1rl45, x2rl45, y2rl45)
    screen.drawLine(x1rl30, y1rl30, x2rl30, y2rl30)
    screen.drawLine(x1rl15, y1rl15, x2rl15, y2rl15)
    screen.drawLine(x1r, y1r, x2r, y2r)
    screen.drawLine(x1rr15, y1rr15, x2rr15, y2rr15)
    screen.drawLine(x1rr30, y1rr30, x2rr30, y2rr30)
    screen.drawLine(x1rr45, y1rr45, x2rr45, y2rr45)

    x1tr = cw+(small_rad-2)*math.cos(roll)
    y1tr = ch_b+(small_rad-2)*math.sin(roll)
    x2tr = cw+small_rad_tri*math.cos(left_tri)
    y2tr = ch_b+small_rad_tri*math.sin(left_tri)
    x3tr = cw+small_rad_tri*math.cos(right_tri)
    y3tr = ch_b+small_rad_tri*math.sin(right_tri)

    screen.setColor(255,0,0)
    screen.drawTriangleF(x1tr, y1tr, x2tr, y2tr, x3tr, y3tr)
end