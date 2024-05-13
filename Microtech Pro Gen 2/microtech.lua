local bootup = ui.MediaPlayer()
bootup:setSource('assets/bootup.mp4'):setAutoPlay(true)

-- sim = ac.getSim()
multi = 1
max = 0
SmoothedAccel = {x = 0, z = 0} -- global default value definition for x and z axis of vec() car.acceleration.

function manifoldpres(boost)
    if boost > max then
        max = boost
        multi = (max + 24.2) / max
    end
    local map = -24.2 + (boost * multi)
    return map
end

function microtech(dt)

    -- Display microtech display
    display.image {
        image = "assets/microtech_screen.dds",
        pos = vec2(0,0),
        size = vec2(2033, 1196)
    }

    SmoothedAccel.z = math.applyLag(SmoothedAccel.z, car.acceleration.z, 0.92, dt)
    accel = SmoothedAccel.z

    local gforce = ((accel > 0.1 and accel) or (accel < -0.1 and accel) or 0)
    local turbo = car.turboBoost * 14.504
    local egt = (car.exhaustTemperature * 9/5) + 32
    local rpm = (car.rpm - 6000 ) / 6000
    local speed = car.poweredWheelsSpeed / 1.609
    local cts = (car.waterTemperature * 9/5) + 32
    local oilpres = car.oilPressure * 14.504
    local tps = car.gas * 100

    -- Numerical MAP Gauge converted to PSI
    display.text {
        text = string.format("%5.1f", manifoldpres(turbo)),
        pos = vec2(20, 133),
        letter = vec2(100, 100),
        font = "4c",
        color = rgbm(1,1,1,1),
        width = 0,
        alignment = 0.5,
        spacing = -20
    }

    -- Numerical EGT gauge converted to F
    display.text {
        text = string.format("%4.0f", egt),
        pos = vec2(20, 380),
        letter = vec2(100, 100),
        font = "4c",
        color = rgbm(1,1,1,1),
        width = 0,
        alignment = 0.5,
        spacing = -20
    }

    -- Numercial G Force
    display.text {
        text = string.format("%5.2f", gforce), -- %.1f = 1 digit after comma, %.2f = 2 digits etc
        pos = vec2(20, 630),
        letter = vec2(100, 100),
        font = "4c",
        color = rgbm(1,1,1,1),
        width = 0,
        alignment = 0.5,
        spacing = -20
    }
    
    -- Numercial Tyre Pressure Front Left
    display.text {
        text = string.format("%.0f", car.wheels[0].tyrePressure), -- %.1f = 1 digit after comma, %.2f = 2 digits etc
        pos = vec2(40, 880),
        letter = vec2(80, 80),
        font = "4c",
        color = rgbm(1,1,1,1),
        width = 0,
        alignment = 0.5,
        spacing = -10
    }

    -- Numercial Tyre Pressure Rear Left
    display.text {
        text = string.format("%.0f", car.wheels[2].tyrePressure), -- %.1f = 1 digit after comma, %.2f = 2 digits etc
        pos = vec2(40, 960),
        letter = vec2(80, 80),
        font = "4c",
        color = rgbm(1,1,1,1),
        width = 0,
        alignment = 0.5,
        spacing = -10
    }

    -- Numercial Tyre Pressure Front Right
    display.text {
        text = string.format("%.0f", car.wheels[1].tyrePressure), -- %.1f = 1 digit after comma, %.2f = 2 digits etc
        pos = vec2(270, 880),
        letter = vec2(80, 80),
        font = "4c",
        color = rgbm(1,1,1,1),
        width = 0,
        alignment = 0.5,
        spacing = -10
    }

    -- Numercial Tyre Pressure Rear Right
    display.text {
        text = string.format("%.0f", car.wheels[3].tyrePressure), -- %.1f = 1 digit after comma, %.2f = 2 digits etc
        pos = vec2(270, 960),
        letter = vec2(80, 80),
        font = "4c",
        color = rgbm(1,1,1,1),
        width = 0,
        alignment = 0.5,
        spacing = -10
    }

    -- Numerical Gear display
    local gearText = tostring(car.gear) -- needs to be converted so that neutral and reverse display correctly (-1 = R, 0 = N)
    if car.gear == -1 then
        gearText = "R"
    end
    if car.gear == 0 then
        gearText = "N"
    end
    display.text {
        text = gearText,
        pos = vec2(520, 550),
        letter = vec2(500, 500),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,0,1),
        width = 0,
        alignment = 0.5,
        spacing = 0
    }

    -- Numerical RPM Gauge
    display.text {
        text = string.format("%5.0f", car.rpm), -- %.1f = 1 digit after comma, %.2f = 2 digits etc
        pos = vec2(650, 276),
        letter = vec2(200, 200),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,0,1),
        width = 0,
        alignment = 0.5,
        spacing = -60
    }

    -- Graphical RPM Gauge
    local value = math.saturate(rpm) -- saturate clamps value between 0 and 1
    display.image {
        image = "assets/RPM_low.dds", -- name of the texture to display
        pos = vec2(511, 157), -- coordinates of top left corner of the texture, pay attention to resolution of that texture
        size = vec2(971 * value, 186), -- size of the image, "value *" makes it expand towards that maximum value
        uvStart = vec2(0, 0), -- uv coordinate of the top left corner (default is 0, 0)
        uvEnd = vec2(value, 1) -- uv coordinate of the bottom right corner (default is 1, 1), 0-8000rpms = value, 1 as range for the "uncovering fo the texture"
    }

    -- Numerical Speed Gauge converted to MPH
    display.text {
        text = string.format("%3.0f", speed), -- %.1f = 1 digit after comma, %.2f = 2 digits etc
        pos = vec2(977, 647),
        letter = vec2(200, 200),
        font = "mclarenmp4gt3",
        color = rgbm(1,0,0,1),
        width = 0,
        alignment = 0.5,
        spacing = -60
    }

    -- Numerical Coolant Temp Gauge
    display.text {
        text = string.format("%.f", cts),
        pos = vec2(1650, 133),
        letter = vec2(100, 100),
        font = "4c",
        color = rgbm(1,1,1,1),
        width = 0,
        alignment = 0.5,
        spacing = -20
    }

    -- Numerical Oil Pressure Gauge
    display.text {
        text = string.format("%5.1f", oilpres),
        pos = vec2(1550, 380),
        letter = vec2(100, 100),
        font = "4c",
        color = rgbm(1,1,1,1),
        width = 0,
        alignment = 0.5,
        spacing = -20
    }

    -- Numerical TPS Gauge
    display.text {
        text = string.format("%3.0f", tps),
        pos = vec2(1650, 620),
        letter = vec2(100, 100),
        font = "4c",
        color = rgbm(1,1,1,1),
        width = 0,
        alignment = 0.5,
        spacing = -20
    }

    -- Numerical Fuel Gauge
    display.text {
        text = string.format("%5.1f", car.fuel),
        pos = vec2(1550, 900),
        letter = vec2(100, 100),
        font = "4c",
        color = rgbm(1,1,1,1),
        width = 0,
        alignment = 0.5,
        spacing = -20
    }
    
    -- Danger to Manifold
    if (car.rpm >= 10500) then
        display.image {
          image = 'assets/shift.dds',
          pos = vec2(385, 230),
          size = vec2(1218, 758)
        }
    end 
end

function video(dt)
    if (bootup:ended()) then
        microtech(dt)
    else
        ui.drawImage(bootup, vec2(), vec2(2033, 1196))
    end
end

refreshRate = 0.02222 -- 45 fps
curDelta = 0

function update(dt)
    --ac.debug("Update Delta", dt)
    curDelta = curDelta+dt
	if (curDelta <= refreshRate) then
		return false
	elseif (curDelta >= refreshRate) then
		curDelta = 0
	end
    video(dt)
end