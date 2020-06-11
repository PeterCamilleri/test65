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

    if source
      @options[:asm_src] = [source]
    else
      @options[:asm_src] = []
    end

    @options[:target] = "sim65c02"
    @options[:ca65_paths] = ["#{@options[:gem_root]}/asminc"]
    @options[:objs] = []
    @options[:libs] = ["sim65c02.lib"]
    @options[:config] = "#{@options[:gem_root]}/cfg/test65.cfg"
    @quiet = @options[:quiet].to_s
  end

  # Cleanup after ourselves
  def clean_up
    # Remove objects and executable unless told to keep them.
    unless @options[:keep]
      File.delete(@target) if File.exists?(@target)

      @options[:objs].each do |file|
        File.delete(file) if File.exists?(file)
      end
    end

    # Remove listing files unless they were requested.
    unless @options[:list]
      @options[:objs].each do |file|
        file = change_type(file, ".lst")
        File.delete(file) if File.exists?(file)
      end
    end

    # Remove the map file if needed.
    File.delete(@map_file) if !@options[:map] && File.exists?(@map_file)

    # Always remove this file if it exists.
    File.delete("_kwhyit") if File.exists?("_kwhyit")
  end

end
