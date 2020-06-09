# Run a test script for the test65 program.

require_relative 'enclosures/utils'
require_relative 'enclosures/ca65'
require_relative 'enclosures/ld65'
require_relative 'enclosures/sim65'

class TestScript

  # Create a test script object and set up its default options.
  def initialize(options={}, source=nil)
    @options = options.full_dup
    @phase   = :create

    @options[:target] = "sim65c02"
    @options[:config] = "#{@options[:gem_root]}/cfg/test65.cfg"
    @options[:asminc] = ["#{@options[:gem_root]}/asminc"]
    @options[:libs]   = ["sim65c02.lib"]

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

end
