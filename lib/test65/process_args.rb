
module Test65

  # Process the command line arguments
  def self.process_args

    opts = GetoptLong.new(
      [ "--help",       "-h", "-?", GetoptLong::NO_ARGUMENT ],
      [ "--version",    "-v",       GetoptLong::NO_ARGUMENT ],
      [ "--file",       "-f",       GetoptLong::REQUIRED_ARGUMENT ],
      [ "--dir",        "-d",       GetoptLong::REQUIRED_ARGUMENT ])

    opts.each do |opt, arg|
      case opt
      when "--help"
        display_help
      when "--version"
        display_version
      when "--file"
        @file = arg
      when "--dir"
        @directory = arg
      else
        fail "Invalid option: #{opt}"
      end
    end

  end

end
