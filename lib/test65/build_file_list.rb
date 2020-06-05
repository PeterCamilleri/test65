# Build the list of test and library files to be processed.

module Test65
  # Find the files to be tested.
  def self.build_file_list(path)
    if @test_files.empty?
      scan_files(path)
    else
      check_files(path)
    end

    puts "Processing #{@test_files.length} test file(s)" if @verbose_option
  end

  # Scan the path for files to be processed.
  def self.scan_files(path)
    @test_files = Dir.glob(path + "/t65*.a65")
    fail "Cannot locate any test files" if @test_files.empty?
  end

  # Check the list of files to be processed.
  def self.check_files(path)
    @test_files = @test_files.map do |file|
      std_file = standardize_path(file)

      if !(found = Dir.glob(std_file)).empty?
        found.map {|subfile| File.absolute_path(file) }
      elsif !(found = Dir.glob(path + "/" + std_file)).empty?
        found
      else
        fail "Cannot locate the file #{file}"
      end
    end.flatten
  end

end
