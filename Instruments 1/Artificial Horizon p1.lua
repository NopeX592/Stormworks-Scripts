function onTick()
    heading = input.getNumber(1)
    tilt_f = (input.getNumber(2)*4)*90
    tilt_l = (input.getNumber(3)*4)*90
    altitude = input.getNumber(4)
    speed = input.getNumber(5)

    vel_conv = property.getBool("Velocity Conv")
    if vel_conv then
        speed = speed * 1.9443844
    end
    alt_adj = property.getNumber("Alt Adjust")
    altitude = altitude - alt_adj


    if speed < 10 and speed > -10 then --rounding
        speed = speed * 10
        speed = math.floor(speed)
        speed = speed / 10
    else
        speed = math.floor(speed)
    end
    if altitude < 10 then
        altitude = altitude * 10
        altitude = math.floor(altitude)
        altitude = altitude / 10
    else
        altitude = math.floor(altitude)
    end
    r_altitude = math.floor(altitude)
    r_speed = math.floor(speed)
end

function onDraw()
	w = screen.getWidth()
	h = screen.getHeight()
    cw = w-48
    ch = h-24
    ch_b = ch+(h/4)

    rad = w+h
    small_rad = (w+h)/5
    small_rad_in = small_rad-5

    pitch = math.acos(tilt_f/180)
    roll = math.rad(90 - tilt_l)
    t_roll = math.rad(0 - tilt_l)
    b_roll = math.rad(180 - tilt_l)
    roll_line = math.rad(90)
    roll_liner15 = math.rad(105)
    roll_linel15 = math.rad(75)

    x1 = cw+rad*math.cos(roll+pitch)
    y1 = ch_b+rad*math.sin(roll+pitch)
    x2 = cw+rad*math.cos(roll-pitch)
    y2 = ch_b+rad*math.sin(roll-pitch)
    x3 = cw+rad*math.cos(t_roll-pitch)
    y3 = ch_b+rad*math.sin(t_roll-pitch)
    x4 = cw+rad*math.cos(b_roll-pitch)
    y4 = ch_b+rad*math.sin(b_roll-pitch)

    screen.setColor(40,114,151) --blue
    screen.drawTriangleF(x1, y1, x2, y2, x3, y3)
    screen.setColor(94,60,34) --brown
    screen.drawTriangleF(x1, y1, x2, y2, x4, y4)

    screen.setColor(255,255,255) --center line
    screen.drawLine(0, ch_b, w/2-4, ch_b)
    screen.drawLine(w/2+5, ch_b, w, ch_b)
    screen.drawLine(cw, ch_b+5, cw-5, ch_b)
    screen.drawLine(cw, ch_b+5, cw+5, ch_b)


    screen.setColor(25,25,25,125) --speed and altitude
    screen.drawRectF(0, ch_b-2, w/3+1, 5)
    screen.drawRectF(w-(w/3), ch_b-2, w-(w/3), 5)

    screen.setColor(0,0,0)
    screen.drawTextBox(0, ch_b-2, w/3, 5, speed, 1, 0)
    screen.drawTextBox(w-(w/3), ch_b-2, w/3, 5, altitude, -1, 0)

    screen.setColor(0,0,0,125)
    screen.drawTextBox(0, ch_b-2-12, w/3, 5, r_speed+10, 1, 0)
    screen.drawTextBox(0, ch_b-2-6, w/3, 5, r_speed+5, 1, 0)
    screen.drawTextBox(0, ch_b-2+6, w/3, 5, r_speed-5, 1, 0)
    screen.drawTextBox(0, ch_b-2+12, w/3, 5, r_speed-10, 1, 0)

    screen.drawTextBox(w-(w/3), ch_b-2-12, w/3, 5, r_altitude+10, -1, 0)
    screen.drawTextBox(w-(w/3), ch_b-2-6, w/3, 5, r_altitude+5, -1, 0)
    if altitude > 5 then
        screen.drawTextBox(w-(w/3), ch_b-2+6, w/3, 5, r_altitude-5, -1, 0)
    end
    if altitude > 10 then
        screen.drawTextBox(w-(w/3), ch_b-2+12, w/3, 5, r_altitude-10, -1, 0)
    end

    screen.setColor(0,0,0) --heading
    heading = math.floor(heading)
    screen.drawTextBox(0, 1, w, 5, heading, 0, 0)
end