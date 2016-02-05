# module encapsulating the calculation of the time difference
# between Gosu::Window#update calls
module DeltaTime
  # this should be called at the start of Gosu::Window#update
  def delta_time!
    now = Gosu.milliseconds

    @last_update ||= now
    @delta_time = now - @last_update

    @last_update = now
  end

  def delta
    @delta_time
  end

  def delta_since(milliseconds)
    [@last_update - milliseconds, 0].max
  end
end
