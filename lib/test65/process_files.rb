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

    generate_names(file)
    ca65
    ld65
    sim65

  rescue => err
    puts err
    @error_count += 1
  ensure
    cleanup
  end

  # Setup the various intermediate file names.
  def self.generate_names(file)
    @source = file
    @object = file.gsub(/\...?.?\z/, ".o")
    @output = file.gsub(/\...?.?\z/, ".out")
    @list   = file.gsub(/\...?.?\z/, ".lst")
  end

  # Assemble some code.
  def self.ca65
    system("ca65 --target sim65c02 -I #{@asminc} #{@source} -o #{@object} #{@quiet}\n")
    fail "Error assembling #{@source}" unless $?.exitstatus == 0
  end

  # Link some code.
  def self.ld65
    system("ld65 --target sim65c02 --lib sim65c02.lib #{@object} -o #{@output} #{@quiet}\n")
    fail "Error linking #{@source}." unless $?.exitstatus == 0
  end

  # Simulate some code.
  def self.sim65
    system("sim65 #{@output}\n")
    status = $?.exitstatus
    fail "Test #{@source} failed with error code: #{status}" unless $?.exitstatus == 0
  end

  # Cleanup after ourselves.
  def self.cleanup
    File.delete(@output)   if File.exists?(@output)
    File.delete(@object)   if File.exists?(@object)
    File.delete("_kwhyit") if File.exists?("_kwhyit")
  end

end