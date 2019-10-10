# Process the test files.

module Test65

  # Process the list of file
  def self.process_file_list
    @file_list.each do |file|
      process_file(file)
    end

    fail "#{@error_count} tests failed." if @error_count > 0
  end

  # Process a file.
  def self.process_file(file)
    @error_count = 0
    puts file if @debug

    ca65(file)
    ld65()
    sim65()

  rescue => err
    puts err if @debug
    @error_count += 1
  ensure
    system("rm test.out")
    system("rm test.o")
  end

  # Assemble some code.
  def self.ca65(file)
    unless system("ca65 --target sim65c02 #{file} -o test.o\n")
      fail "Error assembling #{file}"
    end
  end

  # Link some code.
  def self.ld65
    unless system("ld65 --target sim65c02 --lib sim65c02.lib test.o -o test.out\n")
      fail "Error linking test."
    end
  end

  # Simulate some code.
  def self.sim65
    system("sim65 test.out\n")
    status = $?.exitstatus
    fail "Test failed with error code: #{status}" if status > 0
  end

end