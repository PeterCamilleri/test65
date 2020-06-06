# Process the command line arguments for the test65 program.

module Test65
  # Process the command line arguments.
  def self.process_args

    # Set options to default values.
    @keep_option    = false
    @list_option    = false
    @map_option     = false
    @verbose_option = false
    @quiet_option   = ""
    @lib, path = [], nil

    opts = GetoptLong.new(
      ["--help",       "-h", "-?", GetoptLong::NO_ARGUMENT],
      ["--list",       "-l",       GetoptLong::NO_ARGUMENT],
      ["--map",        "-m",       GetoptLong::NO_ARGUMENT],
      ["--keep",       "-k",       GetoptLong::NO_ARGUMENT],
      ["--path",       "-p",       GetoptLong::REQUIRED_ARGUMENT],
      ["--quiet",      "-q",       GetoptLong::NO_ARGUMENT],
      ["--verbose",    "-v",       GetoptLong::NO_ARGUMENT],
      ["--version",                GetoptLong::NO_ARGUMENT])

    opts.each do |opt, arg|
      case opt
      when "--help"
        puts IO.read(@gem_root + "/help.txt")
        exit
      when "--keep"
        @keep_option = true
      when "--list"
        @list_option = true
      when "--map"
        @map_option = true
      when "--path"
        unless path
          path = File.absolute_path(standardize_path(arg))
        else
          fail "Multiple path options are not allowed."
        end
      when "--quiet"
        @quiet_option = "2> _kwhyit"
      when "--verbose"
        @verbose_option = true
      when "--version"
        puts "test65 Version #{VERSION}"
        exit
      else
        fail "Invalid option: #{opt}"
      end
    end

    @test_files = ARGV

    path

  rescue => err
    puts "Error: #{err.to_s}"
    puts
    puts IO.read(@gem_root + "/help.txt")
    exit
  end

end
