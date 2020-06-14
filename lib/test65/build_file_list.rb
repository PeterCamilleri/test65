# Build the list of test and library files to be processed.

module Test65
  # Find the files to be tested.
  def self.build_file_list
    if @arg_files.empty?
      scan_files
    else
      check_files
    end

    puts "Processing #{@test_files.length} test file(s)" if @options[:verbose]
  end

  # Scan the path for files to be processed.
  def self.scan_files
    @test_files = Dir.glob(@options[:path] + "/t65*.a65") +
                  Dir.glob(@options[:path] + "/t65*.rb")
    fail "Cannot locate any test files" if @test_files.empty?
  end

  # Check the list of files to be processed.
  def self.check_files
    @test_files = @arg_files.map do |file|
      std_file = file.standardize_path

      if !(found = Dir.glob(std_file)).empty?
        found.map {|subfile| File.absolute_path(file) }
      elsif !(found = Dir.glob(@options[:path] + "/" + std_file)).empty?
        found
      else
        fail "Cannot locate the file #{file}"
      end
    end.flatten
  end

end
