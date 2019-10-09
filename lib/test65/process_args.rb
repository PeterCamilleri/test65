
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
        display_version
      when "--file"
        @file_list << arg
      when "--path"
        @path = arg
      else
        fail "Invalid option: #{opt}"
      end
    end

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
