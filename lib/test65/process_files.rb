# Process the test files.

module Test65

  # Process the list of files
  def self.process_file_list
    @error_count = 0

    @test_files.each do |file|
      process_file(file)
    end

    if @error_count > 0
      fail "#{@error_count} tests failed."
    else
      puts "OK: All tests passed."
    end
  end

  # Process a file.
  def self.process_file(file)
    puts localize_path(file) if @options[:verbose]

    test_script = TestScript.new(@options, file)
    test_script.ca65
    test_script.ld65
    test_script.sim65

  rescue => err
    puts err
    puts err.backtrace
    @error_count += 1
  ensure
    test_script.clean_up
  end

end