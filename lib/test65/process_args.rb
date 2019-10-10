# Process the command line arguments for the test65 program.

module Test65
  # Process the command line arguments
  def self.process_args
    @debug, path = false, nil

    opts = GetoptLong.new(
      [ "--help",       "-h", "-?", GetoptLong::NO_ARGUMENT ],
      [ "--version",    "-v",       GetoptLong::NO_ARGUMENT ],
      [ "--path",       "-p",       GetoptLong::REQUIRED_ARGUMENT ],
      [ "--debug",      "-d",       GetoptLong::NO_ARGUMENT ])

    opts.each do |opt, arg|
      case opt
      when "--help"
        display_help
        exit
      when "--debug"
        @debug = true
      when "--version"
        puts "test65 Version #{VERSION}"
        exit
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

  # Display program usage info.
  def self.display_help
    puts <<-EOF
test65 - Run tests of 65c02 assembler code.

Usage: test65 {options} {files}

Options:
  --help, -h, -?   Display this message and exit.
  --version, -v    Display the program version and exit.
  --path, -p       Specify the path to the test files. (Only 1 allowed)
  --debug, -d      Display lots of useful progress info.

Files: An optional list of test files.

Notes:
- By default, test files are located in a folder called "t65" in the current
  folder or one of its parent folders.
- If no files are specified, then all files matching "t65*.a65" in the test
  folder are tested. Otherwise only the specified file(s) are tested.

    EOF
  end

end
