# The Typespeed game
class Typespeed < Gosu::Window
  include States

  register_states :splash, :playing, :gameover

  def initialize(width = 800, height = 600, fullscreen = false)
    super
    self.caption = "Typespeed"
  end

  def update
  end

  def draw
  end
end
