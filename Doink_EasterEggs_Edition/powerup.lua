local used_red=true
local counter = 0
local ready_to_randomize = true
local power_button_red
local current_powerup
local staging_powerup
local loading

local function randomizer()
  rand_red=math.random(5)
  if rand_red==1 then
    loading=display.newImageRect("powerups/powerup1.png", 30, 30)
  elseif rand_red==2 then
    loading=display.newImageRect("powerups/powerup2.png", 30, 30)
  elseif rand_red==3 then
    loading=display.newImageRect("powerups/powerup3.png", 30, 30)
  elseif rand_red==4 then
    loading=display.newImageRect("powerups/powerup4.png", 30, 30)
  elseif rand_red==5 then
    loading=display.newImageRect("powerups/powerup5.png", 30, 30)
  end
  counter=counter+1
  loading.x = display.contentCenterX + 115
  loading.y = display.contentCenterY-45
  if counter~=5 then
    timer.performWithDelay(700, randomizer)
  else
    if used_red then
      current_powerup=rand_red
      used_red=false
    else
      staging_powerup=rand_red
      ready_to_randomize=false
    end
  end
end

local function powerup()
  if used_red and ready_to_randomize then
    randomizer()
    counter=0
    powerup()
  end
  elseif used_red and not ready_to_randomize then
    current_powerup=staging_powerup
    used_red=false
    ready_to_randomize=true
    powerup()
  elseif not used_red and ready_to_randomize then
    randomizer()
    counter=0
    if current_powerup==1 then
      power_button_red=display.newImageRect("powerups/powerup1.png", 30, 30 )
    elseif current_powerup==2 then
      power_button_red=display.newImageRect("powerups/powerup2.png", 30, 30 )
    elseif current_powerup==3 then
      power_button_red=display.newImageRect("powerups/powerup3.png", 30, 30 )
    elseif current_powerup==4 then
      power_button_red=display.newImageRect("powerups/powerup4.png", 30, 30 )
    elseif current_powerup==5 then
      power_button_red=display.newImageRect("powerups/powerup5.png", 30, 30 )
    end
    power_button_red.x = display.contentCenterX + 78
    power_button_red.y = display.contentCenterY-65
    power_button_red:addEventListener("tap", red_powerup_usage)
  end
end

local function red_powerup_usage()
    power_button_red.fill.effect = "filter.grayscale"
    used_red=true
    if current_powerup==1 then
      local powerup1_sound = audio.loadSound( "sounds/powerup1_sound.wav")
      ball.isAwake=false
    elseif current_powerup==2 then
      local powerup2_sound = audio.loadSound( "sounds/powerup2_sound.wav" )
      audio.play(powerup2_sound, {channel=6})
    elseif current_powerup==3 then
      local powerup3_sound = audio.loadSound( "sounds/powerup3_sound.wav" )
      audio.play(powerup3_sound, {channel=6})
      shootPowerDefault=0.1
      timer.performWithDelay(1500, restorePower)
    elseif current_powerup==4 then
      local powerup4_sound = audio.loadSound( "sounds/powerup4_sound.wav" )
      audio.play(powerup4_sound, {channel=6})
      pdim=30
      timer.performWithDelay(1500, restoreDim)
    end
  end


local function restorePower()
	shootPowerDefault=0.01
end

local function restoreDim()
  pdim=10
end
