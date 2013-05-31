# This is the player script
class Player# Here we define the class called player and assigned variables, which we can access from other scripts
  def initialize(window)
    @image = Gosu::Image.new(window, "media/ship.png", false)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @sound_collect = Gosu::Sample.new(window, "media/collect.wav")
    @sound_upgrade = Gosu::Sample.new(window, "media/upgrade.wav")
    @sound_explosion = Gosu::Sample.new(window, "media/explosion.wav")
    
    @lives = 3
    @speedlevel = 0
    @maxspeedlevel = 10
    @speedprice = 50
    @score = 0
    @totalstars = 0
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
  def liveboost# This function is called when we press the upgrade button "More lives"
    if @score > 499
      @score -= 500
      @lives += 1
      @sound_upgrade.play(@window.mute)
    end
  end
  
  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def score
    @score
  end
  def speedlevel
    @speedlevel
  end
  def maxspeedlevel
    @maxspeedlevel
  end
  def lives
    @lives
  end
  def speedprice
    @speedprice
  end

  def collect_stars(stars)# This function is called when we hit a star with our ship
    if stars.reject! {|star| Gosu::distance(@x, @y, star.x, star.y) < 35 } then
      @score += 1
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
        @sound_explosion.play(@window.mute)
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
end