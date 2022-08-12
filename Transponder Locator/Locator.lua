counter = 0
C = {}
D = {}

function onTick()
    --Transponder Inputs
    pulse = input.getBool(2)
    active_on = input.getBool(3)
    valid = input.getBool(4)

    worldX = input.getNumber(7)
    worldY = input.getNumber(8)
    x_off = input.getNumber(9)
    y_off = input.getNumber(10)
    zoom = input.getNumber(11)
    distance = input.getNumber(12)
    --z=clamp(distance*0.00225,1,50)

    if active_on and distance > 0 then
        if pulse then
            counter = 0
        elseif counter<1000 then
            counter = counter + 1
        end
        if distance > 300 and valid then
            if not C[1] or (C[#C].x-worldX)^2+(C[#C].y-worldY)^2>200^2 then
				table.insert(C,{x=worldX,y=worldY,r=distance})
				if #C>3 then
					pc1=2
					pc2=1+math.floor(#C/2)
					pc3=#C
					pc4=pc1
					P=circlesIntersect(C[pc3],C[pc2])
					if P then
						d1=math.abs(math.sqrt((C[pc4].x-P.p1.x)^2+(C[pc4].y-P.p1.y)^2)-C[pc4].r)
						d2=math.abs(math.sqrt((C[pc4].x-P.p2.x)^2+(C[pc4].y-P.p2.y)^2)-C[pc4].r)
						if d1<d2 then choose=1 else choose=2 end
						if choose==1 then
								D={}
								D={x=P.p1.x,y=P.p1.y,p=d1}
						elseif choose==2 then
								D={}
								D={x=P.p2.x,y=P.p2.y,p=d2}
						end
					end	
				end
			end
		end
    else
		C={}
		D={}
	end

    if D.x then
		mcx=(worldX+D.x)/2
		mcy=(worldY+D.y)/2
	else
		mcx=worldX
		mcy=worldY
	end
    output.setNumber(1,D.x)
	output.setNumber(2,D.y)
	output.setNumber(3,D.p)
end

function onDraw()
    w = screen.getWidth()
	h = screen.getHeight()

    cx = w/2
    cy = h/2

    if D.x then
		screen.setColor(20,20,20,50)
		for i,v in ipairs(C) do
			if i==pc1 or i==pc2 or i==pc3 then
				x,y=map.mapToScreen(x_off+mcx,y_off+mcy,zoom,w,h,v.x,v.y)
				screen.drawCircle(x,y,v.r*0.001*h/zoom)
			end
		end
		screen.setColor(90,10,10)
		x,y=map.mapToScreen(x_off+mcx,y_off+mcy,zoom,w,h,D.x,D.y)
		screen.drawCircleF(x,y,1)
		screen.drawCircle(x,y,counter)
		screen.setColor(90,10,10,50)
		screen.drawCircleF(x,y,(D.p+100)*0.001*h/zoom)
	else
		if C[1] then
			text1="loading"
			text2=math.floor(#C%5*100/5).."%"
		elseif on then
			text1="no signal"
			text2="found"
		else
			text1="triangulation"
			text2="in progress"
		end
		screen.setColor(0,0,0)
		screen.drawText(cx-#text1*2.5,cy-7,text1)
		screen.drawText(cx-#text2*2.5,cy,text2)
	end	
end

function circlesIntersect(c1,c2)
    dx=c2.x-c1.x
    dy=c2.y-c1.y
    d=math.sqrt(dx*dx+dy*dy)
    if d>c1.r+c2.r then return end
    if d<math.abs(c1.r-c2.r) then return end
    dx=dx/d
    dy=dy/d
    a=(c1.r*c1.r-c2.r*c2.r+d*d)/(2*d)
    px=c1.x+a*dx
    py=c1.y+a*dy
    h=math.sqrt(c1.r*c1.r-a*a)
    return {
        p1={x=px+h*dy,y=py-h*dx},
        p2={x=px-h*dy,y=py+h*dx},
		d=2*h
    }
end

function clamp(x,min,max)
	if x<min then return min elseif x>max then return max else return x end
end