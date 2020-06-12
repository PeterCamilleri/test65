# Process the command line arguments for the test65 program.

module Test65
  # Process the command line arguments.
  def self.process_args
    @options = {}

    opts = GetoptLong.new(
      ["--debug",      "-d",       GetoptLong::NO_ARGUMENT],
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
      when "--debug"
        @options[:debug] = true
      when "--help"
        puts IO.read(@gem_root + "/help.txt")
        exit
      when "--keep"
        @options[:keep] = true
      when "--list"
        @options[:list] = true
      when "--map"
        @options[:map] = true
      when "--path"
        unless @options[:path]
          @options[:path] = File.absolute_path(standardize_path(arg))
        else
          fail "Multiple path options are not allowed."
        end
      when "--quiet"
        @options[:quiet] = "2> _kwhyit"
      when "--verbose"
        @options[:verbose] = true
      when "--version"
        puts "test65 Version #{VERSION}"
        exit
      else
        fail "Invalid option: #{opt}"
      end
    end

    # A list of files to test may follow the options.
    @arg_files = ARGV

    # Setup some default paths
    @options[:gem_root]   = @gem_root
    @options[:ca65_paths] = @gem_root + "/asminc"
    @options[:cc65_home]  = @cc65_home

  rescue => err
    puts "Error: #{err.to_s}"
    puts err.backtrace if @options[:debug]
    puts
    puts IO.read(@gem_root + "/help.txt")
    exit
  end

end
