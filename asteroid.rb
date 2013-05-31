# The class for the asteroids we should avoid
class Asteroid
  attr_reader :x, :y

  def initialize(window)
    @image = Gosu::Image.new(window, "media/asteroid.png", false)
    @vel_x = @vel_y = 1
    @angle = rand(10)
    @x = rand * 640
    @y = rand * 480
  end
  
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    @angle += 4
  end
  
  def draw  
    @image.draw_rot(@x, @y, 1, @angle)
  end
end