# An enclosure for the sim65 simulator.

class TestScript

  def sim65
    fail "Sequence error: sim65" unless @phase == :simulate
    @phase == :done


  end

end
