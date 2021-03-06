# Process the path to the test files.

module Test65

  # Determine the path to test files.
  def self.process_path
    path = @options[:path] || get_default_path

    localized_path = path.localize_path
    fail "Path #{localized_path} does not exist."  unless File.exists?(path)
    fail "Path #{localized_path} is not a folder." unless File.directory?(path)
    puts "Using path: #{localized_path}" if @options[:verbose]

    @options[:path] = path
  end

  # Get the default test file path if one was not supplied.
  def self.get_default_path
    search, parent = Pathname.new(Dir.pwd), nil

    while true
      test = search.to_s + "/t65"

      if File.exists?(test)
        return test if File.directory?(test)
        fail "The file #{local_path(test)} is not a folder."
      end

      search, parent = search.parent, search

      fail "Default path not found." if search == parent
    end

  end

end
