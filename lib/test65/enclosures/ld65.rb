# An enclosure for the ld65 linker.

class TestScript

  def ld65(*more_files)
    fail "Sequence error" unless @phase == :create
    @phase == :link

    object_files = (@options[:objs] + more_files).flatten.sort


  end

end
