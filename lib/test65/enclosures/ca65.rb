# An enclosure for the ca65 assembler.

class TestScript

  # Assemble some files
  def ca65(*more_files)
    fail "Sequence error" unless @phase == :create

    source_files = (@options[:asm_src] + more_files).flatten
    @options[:asm_src] = []

    # Convert source assemble files into object files.
    source_files.each do |source_file|


      @options[:objs] << change_type(source_file, ".o")
    end
  end
end
