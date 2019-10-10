# test65

require 'english'
require 'getoptlong'
require 'pathname'
require 'rbconfig'

require_relative 'test65/process_args'
require_relative 'test65/std_path'
require_relative 'test65/host'
require_relative 'test65/version'

module Test65

  # The code entry point. Run some 65c02 tests.
  # Returns
  #   0 for success
  #   1 for failure
  def self.process
    process_args

  rescue => err
    puts "Error: #{err.to_s}"
  end

end
