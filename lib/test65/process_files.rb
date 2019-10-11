# Process the test files.

module Test65

  # Process the list of files
  def self.process_file_list
    @error_count = 0

    @file_list.each do |file|
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
    puts file if @debug

    ca65(file)
    ld65(file)
    sim65(file)

  rescue => err
    puts err
    @error_count += 1
  ensure
    File.delete("test.out") if File.exists?("test.out")
    File.delete("test.o")   if File.exists?("test.o")
    File.delete("_kwhyit")  if File.exists?("_kwhyit")
  end

  # Assemble some code.
  def self.ca65(file)
    system("ca65 --target sim65c02 -I #{@asminc} #{file} -o test.o #{@quiet}\n")
    fail "Error assembling #{file}" unless $?.exitstatus == 0
  end

  # Link some code.
  def self.ld65(file)
    system("ld65 --target sim65c02 --lib sim65c02.lib test.o -o test.out #{@quiet}\n")
    fail "Error linking #{file}." unless $?.exitstatus == 0
  end

  # Simulate some code.
  def self.sim65(file)
    system("sim65 test.out\n")
    status = $?.exitstatus
    fail "Test #{file} failed with error code: #{status}" unless $?.exitstatus == 0
  end

end