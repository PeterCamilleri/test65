# Process Command Line Args for the Test65 program.

module Test65
  # Find the files to be tested.
  def self.build_file_list(path)
    if @file_list.empty?
      scan_files(path)
    else
      check_files(path)
    end

    puts "Processing #{@file_list.length} test file(s)" if @debug
  end

  # Scan the path for files to be processed.
  def self.scan_files(path)
    @file_list = Dir.glob(path + "/t65*.a65")
    fail "Cannot locate any test files" if @file_list.empty?
  end

  # Check the list of files to be processed.
  def self.check_files(path)
    @file_list = @file_list.map do |file|
      if File.exists?(file)
        File.absolute_path(file)
      elsif File.exists?(result = path + "/" + file)
        result
      else
        fail "Cannot locate the file #{file}"
      end
    end
  end

end
