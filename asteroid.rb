# The class for the asteroids we should avoid
class Asteroid
    attr_reader :x, :y

  def initialize(window)
    @image = Gosu::Image.new(window, "media/asteroid.png", false)
    @image_damage = Gosu::Image.new(window, "media/asteroid_damage.png", false)
    @image_damage_2 = Gosu::Image.new(window, "media/asteroid_damage2.png", false)
    @sound_hit = Gosu::Sample.new(window, "media/hit.wav")
    @sound_explosion = Gosu::Sample.new(window, "media/explosion.wav")
    @vel_x = rand(5)
    @vel_y = rand(5)
    @angle = rand(5)
    @x = rand * 640
    @y = rand * 480
    @window = window
    @health = 6
  end
  
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    @angle += 4
  end
  
  def hit_bullet(bullet)
    if bullet.reject! { |bullet| Gosu::distance(@x, @y, bullet.x, bullet.y) < 35 } then
      if @health > 1
        @sound_hit.play(@window.mute)
        @health -= 1
      else
        @sound_explosion.play(@window.mute)
        @window.remove_roid(self)
      end
    end
  end
  def hit_rocket(rocket)
    if rocket.reject! { |rocket| Gosu::distance(@x, @y, rocket.x, rocket.y) < 35 } then
        @sound_explosion.play(@window.mute)
        @window.remove_roid(self)
    end
  end
  
  def destroy
    @x = @y = 1000
  end
  
  def draw  
    if @health > 4
    @image.draw_rot(@x, @y, 1, @angle)
    end
    if @health > 2 && @health < 5
    @image_damage.draw_rot(@x, @y, 1, @angle)
    end
    if @health < 3
    @image_damage_2.draw_rot(@x, @y, 1, @angle)
    end
  end
end