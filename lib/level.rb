class Level
  DEFAULT_WORD_DELAY = 2500 # ms
  DEFAULT_WORD_SPEED = 0.06 # 600 px / 10 s
  WORDS_PER_LEVEL = 6

  def initialize()
    @level = 0
  end

  def update(ref)
    @level = ref.correct / WORDS_PER_LEVEL
  end

  def word_delay
    [
      750,
      DEFAULT_WORD_DELAY - @level * 250
    ].max
  end

  def typing_visible?
    @level < 5
  end

  def word_speed
    [
      0.08,
      DEFAULT_WORD_SPEED + (@level / 2) * 0.005
    ].min
  end
end
