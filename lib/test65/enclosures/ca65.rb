# An enclosure for the ca65 assembler.

class TestScript

  # Assemble some files
  def ca65(*more_files)
    fail "Sequence error" unless @phase == :create

    source_files = (@options[:asm_src] + more_files).flatten.sort


  end
end
