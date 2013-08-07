# This is the bullet script
class Bullet
    attr_reader :x, :y

  def initialize(window)
    @image = Gosu::Image.new(window, "media/bullet.png", false)
    @window = window
    @x = @y = @vel_x = @vel_y = @angle = 0.0
  end
  
  def place(x, y)
    @x, @y = x, y
  end
  
  def shoot(angle, speed)
    @angle = angle
    @vel_x += Gosu::offset_x(@angle, speed)
    @vel_y += Gosu::offset_y(@angle, speed)
  end
  
  def move
    @x += @vel_x unless spent?
    @y += @vel_y unless spent?
  end
  
  def destroy
    @x = @y = 1000
  end
  
  def spent?
    (@x < 0 or @x > 640) or (@y < 0 or @y > 480)
  end
  
  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end

class Rocket < Bullet
  attr_reader :x, :y

  def initialize(window)
    @image = Gosu::Image.new(window, "media/rocket.png", false)
    @window = window
    @x = @y = @vel_x = @vel_y = @angle = 0.0
  end
  
  def place(x, y)
    @x, @y = x, y
  end
  
  def shoot(angle, speed)
    @angle = angle
    @vel_x += Gosu::offset_x(@angle, speed)
    @vel_y += Gosu::offset_y(@angle, speed)
  end
  
  def move
    @x += @vel_x unless spent?
    @y += @vel_y unless spent?
  end
  
  def destroy
    @x = @y = 1000
  end
  
  def spent?
    (@x < 0 or @x > 640) or (@y < 0 or @y > 480)
  end
  
  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end