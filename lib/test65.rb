# test65

require 'english'
require 'getoptlong'
require 'pathname'
require 'rbconfig'

require_relative 'test65/process_files'
require_relative 'test65/process_args'
require_relative 'test65/process_path'
require_relative 'test65/build_file_list'
require_relative 'test65/std_path'
require_relative 'test65/host'
require_relative 'test65/version'

module Test65

  #Figure out where the gem root folder is located
  lib_path = File.dirname(File.absolute_path(__FILE__))
  @gem_root = Pathname.new(lib_path).parent.to_s
  @asminc = @gem_root + "/asminc"

  # The code entry point. Run some 65c02 tests.
  # Returns
  #   0 for success
  #   1 for failure
  def self.process
    build_file_list(process_path(process_args))
    process_file_list

  rescue => err
    puts "Error: #{err.to_s}"
    exit(1)
  end

end
