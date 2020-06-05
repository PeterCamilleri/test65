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
    puts localize_path(file) if @verbose_option

    generate_names(file)
    ca65
    ld65
    sim65

  rescue => err
    puts err
    @error_count += 1
  ensure
    cleanup unless @keep_option
  end

  # Setup the various intermediate file names.
  def self.generate_names(file)
    @source  = file
    @object  = file.gsub(/\...?.?\z/, ".o")
    @output  = file.gsub(/\...?.?\z/, ".out")
    @listing = file.gsub(/\...?.?\z/, ".lst")
    @mapping = file.gsub(/\...?.?\z/, ".map")
  end

  # Assemble some code.
  def self.ca65
    lst = @list_option ? "-l #{@listing}" : ""
    system("ca65 --target sim65c02 -I #{@asminc} #{@source} #{lst} -o #{@object} #{@quiet_option}\n")
    fail "Error assembling #{localize_path(@source)}" unless $?.exitstatus == 0
  end

  # Link some code.
  def self.ld65
    map = @map_option ? "-m #{@mapping}" : ""
    cfg = "-C #{@gem_root}/cfg/test65.cfg"
    system("ld65 --lib sim65c02.lib #{cfg} #{@object} #{map} -o #{@output} #{@quiet_option}\n")
    fail "Error linking #{localize_path(@source)}." unless $?.exitstatus == 0
  end

  # Simulate some code.
  def self.sim65
    system("sim65 #{@output}\n")
    status = $?.exitstatus
    fail "Test #{localize_path(@source)} failed with error code: #{status}" unless $?.exitstatus == 0
  end

  # Cleanup after ourselves.
  def self.cleanup
    File.delete(@output)   if File.exists?(@output)
    File.delete(@object)   if File.exists?(@object)
    File.delete(@listing)  if !@list_option && File.exists?(@listing)
    File.delete(@mapping)  if !@map_option  && File.exists?(@mapping)
    File.delete("_kwhyit") if File.exists?("_kwhyit")
  end

end