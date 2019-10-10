# Process the path to the test files.

module Test65

  # Determine the path to test files.
  def self.process_path(path)
    path = get_default_path unless path
    fail "Path #{local_path(path)} does not exist."  unless File.exists?(path)
    fail "Path #{local_path(path)} is not a folder." unless File.directory?(path)
    puts "Using path: #{path}" if @debug
    path
  end

  # Get the default test file path if one was not supplied.
  def self.get_default_path
    search, parent = Pathname.new(Dir.pwd), nil

    while true
      test = search.to_s + "/t65"

      if File.exists?(test)
        return test if File.directory?(test)
        fail "The file #{test} is not a directory."
      end

      search, parent = search.parent, search

      fail "Default path not found." if search == parent
    end

  end

end
