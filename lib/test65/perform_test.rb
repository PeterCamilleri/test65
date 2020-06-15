# Run a test script for the test65 program.

require_relative 'enclosures/utils'
require_relative 'enclosures/ca65'
require_relative 'enclosures/ld65'
require_relative 'enclosures/sim65'

class TestScript

  # Create a test script object and set up its default options.
  def initialize(options={})
    @options = options.full_dup
    @phase   = :create

    ca65_initialize
    ld65_initialize
    sim65_initialize

    @quiet = @options[:quiet].to_s
  end

  # Cleanup after ourselves
  def clean_up
    # Remove objects and executable unless told to keep them.
    unless @options[:keep]
      File.delete(@output) if File.exists?(@output)

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
  end

end
