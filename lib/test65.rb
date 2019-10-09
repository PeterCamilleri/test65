# test65

require 'english'
require_relative 'test65/version'

module Test65

  # Run some 65c02 tests.
  # Returns
  #   0 for success
  #   2..255 for test failure. The status is the failure code.
  #   :asm for an assembler error
  #   :linker for a linker error
  #   :sim for a simulator error.
  def self.process(args)
  end

end
