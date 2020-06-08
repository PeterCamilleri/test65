# Run a test script for the test65 program.

require_relative 'enclosures/ca65'
require_relative 'enclosures/ld65'
require_relative 'enclosures/sim65'

class TestScript

  # Create a test script object and set up its default options.
  def initialize(options={}, source=nil)
    @options = options.full_dup

    if source
      @options[:asm_src] = [source]
      @options[:objs]    = [change_type(source, ".o")]
      @options[:out]     = change_type(source, ".out")
    else
      @options[:asm_src] = []
      @options[:objs]    = []
      @options[:out]     = "a.out"
    end
  end

  # Create a file name with a new extension.
  def change_type(file, new_ext)
    file.gsub(/\...?.?\z/, new_ext)
  end

end
