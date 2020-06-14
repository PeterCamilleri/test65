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
    puts file.localize_path if @options[:verbose]

    case File.extname(file)
    when ".a65"
      script(file) { ca65; ld65; sim65 }

    when ".rb"
      load file

    else
      fail "Don't know how to process #{files}"
    end
  end

  # Process a test script.
  def self.script(file=nil, &block)
    test_script = TestScript.new(@options, file)
    test_script.instance_exec(&block)
  rescue => err
    puts err
    puts err.backtrace if @options[:debug]
    @error_count += 1
  ensure
    test_script.clean_up
  end

end
