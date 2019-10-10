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
    search = Pathname.new(Dir.pwd)

    while search != (parent = search.parent)
      test = search.to_s + "/t65"
      return test if File.exists?(test) && File.directory?(test)
      search = parent
    end

    fail "Default path not found."
  end

end
