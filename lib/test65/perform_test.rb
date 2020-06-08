# Run a test script for the test65 program.

require_relative 'enclosures/ca65'
require_relative 'enclosures/ld65'
require_relative 'enclosures/sim65'

class TestScript

  # Create a test script object and set up its default options.
  def initialize(options={}, source=nil)
    @options = options.full_dup
    @options[:asm_src] = source.nil? ? [] : [source]
    @options[:objs]    = []
  end

end
