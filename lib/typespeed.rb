# The Typespeed game
class Typespeed < Gosu::Window
  include States
  include DeltaTime

  register_states :splash, :playing, :gameover

  def initialize(width = 800, height = 600, fullscreen = false)
    super
    self.caption = "Typespeed"

    @dictionary = File.open("lib/assets/words.txt").map(&:strip)
    @words = []

    @input = UserInput.new(self)
    @ref = Referee.new(@words, @input)
  end

  def update
    delta_time!

    @state_text ||= Gosu::Image.from_text("States are #{states.inspect}", 36)
    @cstate_text ||= Gosu::Image.from_text("Current state #{state.inspect}", 36)
    @delta_text = Gosu::Image.from_text("Now: #{Gosu.milliseconds}, delta #{delta}", 36)

    # good api?
    # every 5.seconds do
    #   Gosu::Image.from_text("Now: #{Gosu.milliseconds}, delta #{delta}", 36)
    # end.and_draw do |thingy|
    #   thingy.draw_rot(width / 2, height / 2 + 80, 0, 0)
    # end
    @last_static_word_at ||= Gosu.milliseconds
    if delta_since(@last_static_word_at) > 2500 || @word.nil?
      @word = Gosu::Image.from_text(@dictionary.sample, 36)
      @last_static_word_at = Gosu.milliseconds
    end

    @last_word_at ||= Gosu.milliseconds
    @words.reject!(&:update)
    if delta_since(@last_word_at) > 2500
      word = Word.new(@dictionary.sample, 240, self)
      @words << word
      @last_word_at = Gosu.milliseconds
    end
  end

  def draw
    @state_text.draw_rot(width / 2, @state_text.height / 2, 0, 0)
    @cstate_text.draw_rot(width / 2, 40, 0, 0)
    @delta_text.draw_rot(width / 2, 80, 0, 0)
    @word.draw_rot(width / 2, 120, 0, 0) if @word

    @words.map(&:draw)
  end

  def button_down id
    case id
    when Gosu::KbReturn
      @ref.score!
      puts "User submitted: #{@input.last_submission}"
    end
  end
end
