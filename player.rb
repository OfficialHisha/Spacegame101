# This is the player script
require_relative 'bullet.rb'
class Player# Here we define the class called player and assigned variables, which we can access from other scripts
    attr_reader :bullets, :rockets, :window
  
  def initialize(window)
    @image = Gosu::Image.new(window, "media/ship.png", false)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @sound_collect = Gosu::Sample.new(window, "media/collect.wav")
    @sound_upgrade = Gosu::Sample.new(window, "media/upgrade.wav")
    @sound_hit = Gosu::Sample.new(window, "media/hit.wav")
    @sound_shoot = Gosu::Sample.new(window, "media/shoot.wav")
    @sound_launch_rocket = Gosu::Sample.new(window, "media/launchrocket.wav")
    @sound_explosion = Gosu::Sample.new(window, "media/explosion.wav")
    
    @bullets = []
    @rockets = []
    @laser_cool_time = 100
    @rocket_cool = 200
    @laser_cool = 100
    @laserlevel = 0
    @maxlaserlevel = 5
    @laserprice = 100
    @lives = 3
    @speedlevel = 0
    @maxspeedlevel = 10
    @speedprice = 50
    @score = 0
    @totalstars = 0
    @starcount = 0
    @kills = 0
    @speed = 0.2
    @window = window
  end

  def warp(x, y)
      @x, @y = x, y
  end
  
  def turn_left
    @angle -= 4.5
  end
  
  def turn_right
    @angle += 4.5
  end
  
  def accelerate
      @vel_x += Gosu::offset_x(@angle, @speed)
      @vel_y += Gosu::offset_y(@angle, @speed)
  end
  
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def speedboost# This function is called when we press the upgrade button "Speed upgrade"
    if @score > @speedprice-1 && @speedlevel < @maxspeedlevel
      @score -= @speedprice
      @speed += 0.01
      @speedlevel += 1
      @speedprice += 50
      @sound_upgrade.play(@window.mute)
    end
  end
  def lasercoolboost# This function is called when we press the upgrade button "Laser upgrade"
    if @score > @laserprice-1 && @laserlevel < @maxlaserlevel
      @score -= @laserprice
      @laser_cool_time -= 10
      @laserlevel += 1
      @laserprice += 50
      @sound_upgrade.play(@window.mute)
    end
  end
  def liveboost# This function is called when we press the upgrade button "More lives"
    if @score > 249
      @score -= 250
      @lives += 1
      @sound_upgrade.play(@window.mute)
    end
  end
  def launcher
    @sound_upgrade.play(@window.mute)
    @score -= 500
  end
  
  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def shoot_laser
    if @laser_cool == 0
      @laser_cool = @laser_cool_time
      @sound_shoot.play(@window.mute)
      @bullets.reject! { |bullet| bullet.destroy }
      @bullet = Bullet.new(@window)
      @bullet.place(@x, @y)
      @bullet.shoot(@angle, 10)
      @bullets.push(@bullet)
    end
  end
  
  def shoot_rocket
    if @rocket_cool == 0
      @rocket_cool = 500
      @sound_launch_rocket.play(@window.mute)
      @rockets.reject! { |rocket| rocket.destroy }
      @rocket = Rocket.new(@window)
      @rocket.place(@x, @y)
      @rocket.shoot(@angle, 3)
      @rockets.push(@rocket)
    end
  end
  
  def direct_motion()
    @bullets.each do |bullet| 
      @bullet.move
    end
    @rockets.each do |rocket| 
      @rocket.move
    end
    @bullets.reject! { |bullet| bullet.spent? }
    @rockets.reject! { |rocket| rocket.spent? }
    if @rocket_cool > 0
      @rocket_cool -= 1
    end
    if @laser_cool > 0
      @laser_cool -= 1
    end
  end
  
  def asteroid_kill
    @score += 10
    @kills += 1
  end
  
  def collect_stars(stars)# This function is called when we hit a star with our ship
    if stars.reject! {|star| Gosu::distance(@x, @y, star.x, star.y) < 35 } then
      @score += 1
      @starcount += 1
      @sound_collect.play(@window.mute)
      if @totalstars > 99
        @totalstars = 0
        @window.add_roid
      else
        @totalstars += 1
      end
    end
  end
  def hit_asteroid(asteroid)# This function is called when we hit an asteroid with our ship
    if asteroid.reject! {|asteroid| Gosu::distance(@x, @y, asteroid.x, asteroid.y) < 35 } then
      if lives > 1
        @sound_hit.play(@window.mute)
        @lives -= 1
      else
        @sound_explosion.play(@window.mute)
        @window.loose
      end
    end
  end
  
  def cheats(id)
    if id == 1
        @speed += 1
    end
    if id == 2
        @score += 100
    end
    if id == 3
        @maxspeedlevel += 10
    end
  end

# outgoing methods
  def score
    @score
  end
  def speedlevel
    @speedlevel
  end
  def maxspeedlevel
    @maxspeedlevel
  end
  def speedprice
    @speedprice
  end
  def laserlevel
    @laserlevel
  end
  def maxlaserlevel
    @maxlaserlevel
  end
  def laserprice
    @laserprice
  end
    def lives
    @lives
  end
  def starcount
    @starcount
  end
  def kills
    @kills
  end
  def laser_cool
      @laser_cool
  end
  def rocket_cool
      @rocket_cool
  end
end