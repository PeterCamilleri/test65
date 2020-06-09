# An enclosure for the ld65 linker.

class TestScript

  def ld65
    fail "Sequence error" unless [:create, :link].include?(@phase)
    @phase = :simulate

  end

end
