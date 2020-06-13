# test65

require 'english'
require 'getoptlong'
require 'pathname'
require 'rbconfig'
require 'full_dup'

require_relative 'test65/perform_test'
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
  @asminc = @gem_root + "/asminc"   # TODO remove this variable.

  # Figure out where the compiler is.
  temp = ENV["CC65_HOME"]
  fail "The CC65_HOME variable is not set." unless temp
  @cc65_home = temp.standardize_path

  # The code entry point. Run some 65c02 tests.
  # Returns
  #   0 for success
  #   Other for failure
  def self.process
    process_args
    process_path
    build_file_list
    process_file_list

  rescue => err
    puts "Error: #{err.to_s}"
    puts err.backtrace if @options[:debug]
    exit(1)

  ensure
    # Always remove this file if it exists.
    File.delete("_kwhyit") if File.exists?("_kwhyit")
  end

end
