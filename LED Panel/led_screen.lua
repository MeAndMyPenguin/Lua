local video = ui.MediaPlayer()
video:setSource('assets/led.mp4'):setAutoPlay(true):setLooping(true)

function led(dt)
    ui.drawImage(video, vec2(), vec2(1440, 384))
end

refreshRate = 0.05000 -- 20 fps
curDelta = 0

function update(dt)
    --ac.debug("Update Delta", dt)
    curDelta = curDelta+dt
	if (curDelta <= refreshRate) then
		return false
	elseif (curDelta >= refreshRate) then
		curDelta = 0
	end
    led(dt)
end