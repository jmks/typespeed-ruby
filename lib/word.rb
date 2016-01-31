class Word
  DEFAULT_SPEED = 0.06 # 600 px / 10 s
  DEFAULT_X = 0

  attr_reader :value, :speed, :game

  def initialize(word, y, game, x: DEFAULT_X, speed: DEFAULT_SPEED)
    @value = word
    @x = x
    @y = y
    @game = game
    @max_x = game.width
    @speed = speed
    @color = Gosu::Color::GREEN

    build!
  end

  def update
    change_color!
    @x += speed * game.delta
    offscreen?
  end

  def draw
    @display.draw(value, @x, @y, 0, 1, 1, @color)
  end

  private

  def build!
    @display = Gosu::Font.new(24)
  end
  alias_method :rebuild!, :build!

  def change_color!
    return if expected_color == @color

    @color = expected_color
    rebuild!
  end

  def expected_color
    case percent_progress
    when 0..50
      Gosu::Color::GREEN
    when 51..75
      Gosu::Color::YELLOW
    else
      Gosu::Color::RED
    end
  end

  def percent_progress
    (@x / @max_x * 100).to_i
  end

  def offscreen?
    @x >= @max_x
  end
end
