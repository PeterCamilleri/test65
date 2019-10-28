# Build the list of test files to be processed.

module Test65
  # Find the files to be tested.
  def self.build_file_list(path)
    if @file_list.empty?
      scan_files(path)
    else
      check_files(path)
    end

    puts "Processing #{@file_list.length} test file(s)" if @verbose
  end

  # Scan the path for files to be processed.
  def self.scan_files(path)
    @file_list = Dir.glob(path + "/t65*.a65")
    fail "Cannot locate any test files" if @file_list.empty?
  end

  # Check the list of files to be processed.
  def self.check_files(path)
    @file_list = @file_list.map do |file|
      if !(found = Dir.glob(std_path(file))).empty?
        found.map {|subfile| File.absolute_path(file) }
      elsif !(found = Dir.glob(path + "/" + std_path(file))).empty?
        found
      else
        fail "Cannot locate the file #{file}"
      end
    end.flatten
  end

end
