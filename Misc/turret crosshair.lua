function onDraw()
    w = screen.getWidth()
	h = screen.getHeight()

    screen.setColor(125,125,125)
    screen.drawLine((w/2)-2, (h/2), (w/2)+2, (h/2))
    screen.drawLine((w/2), (h/2)-2, (w/2), (h/2)+2)
end