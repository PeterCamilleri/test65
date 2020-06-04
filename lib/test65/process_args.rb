# Process the command line arguments for the test65 program.

module Test65
  # Process the command line arguments
  def self.process_args
    @keep_option = false
    @list_option = false
    @map, @verbose, @quiet, @lib, path = false, false, "", [], nil

    opts = GetoptLong.new(
      ["--help",       "-h", "-?", GetoptLong::NO_ARGUMENT],
      ["--lib",                    GetoptLong::REQUIRED_ARGUMENT],
      ["--list",       "-l",       GetoptLong::NO_ARGUMENT],
      ["--map",        "-m",       GetoptLong::NO_ARGUMENT],
      ["--keep",       "-k",       GetoptLong::NO_ARGUMENT],
      ["--version",                GetoptLong::NO_ARGUMENT],
      ["--path",       "-p",       GetoptLong::REQUIRED_ARGUMENT],
      ["--quiet",      "-q",       GetoptLong::NO_ARGUMENT],
      ["--verbose",    "-v",       GetoptLong::NO_ARGUMENT])

    opts.each do |opt, arg|
      case opt
      when "--help"
        puts IO.read(@gem_root + "/help.txt")
        exit
      when "--verbose"
        @verbose = true
      when "--list"
        @list_option = true
      when "--map"
        @map = true
      when "--keep"
        @keep_option = true
      when "--quiet"
        @quiet = "2> _kwhyit"
      when "--version"
        puts "test65 Version #{VERSION}"
        exit
      when "--lib"
        @lib << arg
      when "--path"
        unless path
          path = File.absolute_path(std_path(arg))
        else
          fail "Multiple path options are not allowed."
        end
      else
        fail "Invalid option: #{opt}"
      end
    end

    @file_list = ARGV

    path
  end

end
