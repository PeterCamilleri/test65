# Process Command Line Args for the Test65 program.

module Test65

  @file_list = []
  @path = nil


  # Process the command line arguments
  def self.process_args
    opts = GetoptLong.new(
      [ "--help",       "-h", "-?", GetoptLong::NO_ARGUMENT ],
      [ "--version",    "-v",       GetoptLong::NO_ARGUMENT ],
      [ "--file",       "-f",       GetoptLong::REQUIRED_ARGUMENT ],
      [ "--path",       "-p",       GetoptLong::REQUIRED_ARGUMENT ])

    opts.each do |opt, arg|
      case opt
      when "--help"
        display_help
      when "--version"
        puts "test65 Version #{VERSION}"
        exit
      when "--file"
        @file_list << std_path(arg)
      when "--path"
        unless @path
          @path = File.absolute_path(std_path(arg))
          fail "Path #{local_path(@path)} does not exist." unless File.exists?(@path)
          fail "Path #{local_path(@path)} is not a folder." unless File.directory?(@path)
        else
          fail "Multiple path options are not allowed."
        end
      else
        fail "Invalid option: #{opt}"
      end
    end

    @path = get_default_path unless @path
    puts "Using path: #{@path}"

    build_file_list
  end

  # Get the default test file path if one was not supplied.
  def self.get_default_path
    search = Pathname.new(Dir.pwd)

    while search != (parent = search.parent)
      test = search.to_s + "/t65"
      return test if File.exists?(test) && File.directory?(test)
      search = parent
    end

    fail "Default path not found."
  end

  # Get the list of files to be processed.
  def self.build_file_list
  end

  # Display program usage info.
  def self.display_help
    puts <<-EOF
test65 - Run tests of 65c02 assembler code.

Usage: test65 {options}

Options:
  --help, -h, -? Display this message and exit.
  --version, -v  Display the program version and exit.
  --file, -f     Specify a test file to test. (Multiple allowed)
  --path, -p     Specify the path to test files. (Only 1 allowed)

    EOF
    exit
  end

end
