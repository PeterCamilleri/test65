# An enclosure for the sim65 simulator.

class TestScript

  def sim65
    fail "Sequence error" unless @phase == :simulate
    @phase == :done


  end

end
