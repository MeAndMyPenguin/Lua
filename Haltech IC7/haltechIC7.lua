local bootup = ui.MediaPlayer()
bootup:setSource('assets/bootup.mp4'):setAutoPlay(true)

function haltech ()

    -- Display haltech display
    display.image {
        image = "assets/Haltech _Hero_1.dds",
        pos = vec2(0,0),
        size = vec2(859, 480)
    }
end

function text ()
    
    -- manifold pressure gauge
    display.text {
        text = string.format("%.1f", car.turboBoost),
        pos = vec2(55, 50),
        letter = vec2(50, 60),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,0,1),
        width = 46,
        alignment = 1,
        spacing = -25
    }

    -- coolant temp gauge
    display.text {
        text = string.format("%.f", car.waterTemperature),
        pos = vec2(55, 160),
        letter = vec2(50, 60),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,0,1),
        width = 46,
        alignment = 1,
        spacing = -20
    }

    -- oil pressure gauge
    display.text {
        text = string.format("%.1f", car.oilPressure),
        pos = vec2(55, 266),
        letter = vec2(50, 60),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,0,1),
        width = 46,
        alignment = 1,
        spacing = -25
    }

    -- oil temperature gauge
    display.text {
        text = string.format("%d", car.oilTemperature),
        pos = vec2(55, 375),
        letter = vec2(50, 60),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,0,1),
        width = 46,
        alignment = 1,
        spacing = -20
    }

    -- EGT gauge
    display.text {
        text = string.format("%.f", car.exhaustTemperature),
        pos = vec2(695, 50),
        letter = vec2(50, 60),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,0,1),
        width = 46,
        alignment = 1,
        spacing = -20
    }

    -- TPS gauge
    display.text {
        text = string.format("%d", car.gas * 100),
        pos = vec2(705, 160),
        letter = vec2(50, 60),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,0,1),
        width = 46,
        alignment = 1,
        spacing = -20
    }

    -- battery gauge
    display.text {
        text = string.format("%.1f", car.batteryVoltage), -- %.1f = 1 digit after comma, %.2f = 2 digits etc
        pos = vec2(685, 266),
        letter = vec2(50, 60),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,0,1),
        width = 46,
        alignment = 1,
        spacing = -25
    }

    -- speed gauge
    display.text {
        text = string.format("%d", car.speedKmh / 1.609), -- %.1f = 1 digit after comma, %.2f = 2 digits etc
        pos = vec2(690, 375),
        letter = vec2(50, 60),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,0,1),
        width = 46,
        alignment = 1,
        spacing = -22
    }

    -- ODO gauge
    display.text {
        text = string.format("%.f", car.distanceDrivenTotalKm), -- %.1f = 1 digit after comma, %.2f = 2 digits etc
        pos = vec2(460, 396),
        letter = vec2(28, 20),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,1,1),
        width = 46,
        alignment = 1,
        spacing = -18
    }

    -- Trip gauge
    display.text {
        text = string.format("%.f", car.distanceDrivenSessionKm), -- %.1f = 1 digit after comma, %.2f = 2 digits etc
        pos = vec2(528, 292),
        letter = vec2(28, 28),
        font = "mclarenmp4gt3",
        color = rgbm(1,1,1,1),
        width = 46,
        alignment = 1,
        spacing = -18
    }

    -- Gear display
    local gearText = tostring(car.gear) -- needs to be converted so that neutral and reverse display correctly (-1 = R, 0 = N)
    if car.gear == -1 then
        gearText = "R"
    end
    if car.gear == 0 then
        gearText = "N"
    end
    display.text {
        text = gearText,
        pos = vec2(462, 282),
        letter = vec2(50, 70),
        font = "mclarenmp4gt3",
        width = 46,
        alignment = 1,
        spacing = 0
    }
end

function animatedBars()
    -- graphical manifold pressure gauge
    local value = math.saturate(car.turboBoost / 3)
    display.rect {
        pos = vec2(3.8, 131),
        size = vec2(38.1, -value * 84.6),
        color = rgbm(1,1,0,1)
    }

    -- graphical coolant temp gauge
    local value = math.saturate(car.waterTemperature / 140)
    display.rect {
        pos = vec2(3.8, 240),
        size = vec2(38.1, -value * 84.6),
        color = rgbm(1,1,0,1)
    }

    -- graphical oil pressure gauge
    local value = math.saturate(car.oilPressure / 10)
    display.rect {
        pos = vec2(3.8, 347),
        size = vec2(38.1, -value * 84.6),
        color = rgbm(1,1,0,1)
    }

    -- graphical oil temperature gauge
    local value = math.saturate(car.oilTemperature / 121)
    display.rect {
        pos = vec2(3.8, 453),
        size = vec2(38.1, -value * 84.6),
        color = rgbm(1,1,0,1)
    }

    -- graphical EGT gauge
    local value = math.saturate(car.exhaustTemperature / 800)
    display.rect {
        pos = vec2(818, 131),
        size = vec2(38.1, -value * 84.6),
        color = rgbm(1,1,0,1)
    }

    -- graphical TPS gauge
    local value = math.saturate(car.gas)
    display.rect {
        pos = vec2(818, 240),
        size = vec2(38.1, -value * 84.6),
        color = rgbm(1,1,0,1)
    }

    -- graphical battery gauge
    local value = math.saturate(car.batteryVoltage / 18)
    display.rect {
        pos = vec2(818, 347),
        size = vec2(38.1, -value * 84.6),
        color = rgbm(1,1,0,1)
    }

    -- graphical speed gauge
    local value = math.saturate(car.speedKmh / 200)
    display.rect {
        pos = vec2(818, 453),
        size = vec2(38.1, -value * 84.6),
        color = rgbm(1,1,0,1)
    }
end

function images()

    -- Display bars
    display.image {
        image = "assets/bars.dds",
        pos = vec2(0,0),
        size = vec2(859, 480)
    }

    -- TC Icon
    if (car.tractionControlMode == 1) then
        display.image {
            image = "assets/traction.dds",
            pos = vec2(348, 277), -- coordinates of top left corner
            size = vec2(20, 26)
        }
    end

    -- Battery Icon
    if (car.batteryVoltage <= 11) then
        display.image {
            image = "assets/battery.dds",
            pos = vec2(382, 277), -- coordinates of top left corner
            size = vec2(31, 23)
        }
    end

    -- CEL Icon
    if (car.engineLifeLeft <= 600) then
        display.image {
            image = "assets/cel.dds",
            pos = vec2(345, 245), -- coordinates of top left corner
            size = vec2(29, 21)
        }
    end

    -- Lights Icon
    if (car.headlightsActive == true) then
        display.image {
            image = "assets/lights.dds",
            pos = vec2(610, 9), -- coordinates of top left corner
            size = vec2(37, 23)
        }
    end

    -- Oil Pressure Icon
    if (car.oilPressure <= 1) then
        display.image {
            image = "assets/oil.dds",
            pos = vec2(380, 248), -- coordinates of top left corner
            size = vec2(38, 17)
        }
    end

    -- Handbrake Icon
    if (car.handbrake == 1) then
        display.image {
            image = "assets/pbrake.dds",
            pos = vec2(226, 9), -- coordinates of top left corner
            size = vec2(28, 23)
        }
    end

    -- Fuel Icon
    if (car.fuel <= 5) then
        display.image {
            image = "assets/gas.dds",
            pos = vec2(390, 310), -- coordinates of top left corner
            size = vec2(18, 23)
        }
    end
end

function needle ()

    -- RPM Needle
    local value = math.saturate(car.rpm / 9000)
    ui.beginRotation()
    
    display.image {
        image = "assets/rpmNeedle.dds",
        pos = vec2(0,0),
        size = vec2(859, 480)
    }
    ui.endPivotRotation(90-value*270, vec2(433,241), vec2(0, 0))
end

function danger ()
    -- Danger to Manifold
    if (car.rpm >= 9000) then
        display.image {
          image = 'assets/danger.dds',
          pos = vec2(60,70),
        size = vec2(739, 360)
        }
    end
end

function script.update(dt)
    if (bootup:ended()) then
        haltech()
        text()
        animatedBars()
        images()
        needle()
        danger()
    else
        ui.drawImage(bootup, vec2(), vec2(859, 480))
    end
end