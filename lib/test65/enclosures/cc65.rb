# An enclosure for the cc65 compiler.
class TestScript

  # Setup cc65
  def cc65_initialize
    @options[:cc65_target] = "sim65c02"
    @options[:cc65_inc_paths] = ["#{@options[:gem_root]}/include"]
  end

  # Add some include paths for the compiler.
  def cc65_inc_paths(*more_paths)
    fail "Sequence error: cc65_inc_paths" unless @phase == :create
    append_option(:cc65_inc_paths, more_paths)
  end

  # Compile some files.
  def cc65(file, options="")
    fail "Sequence error: cc65" unless @phase == :create
    source = File.absolute_path(@options[:path] + "/" + file)
    target = "--target #{@options[:cc65_target]} "
    paths = build_args("--include-dir", @options[:cc65_inc_paths])

    # Convert source C files into assembler files.
    list = @options[:list] ? "--add-source " : ""
    command = "cc65 #{target}#{paths}#{options} #{source} #{@quiet}\n"
    puts command if @options[:debug]
    system(command)
    fail "Error compiling #{source.localize_path}" unless $?.exitstatus == 0

    # Convert intermediate assembler files into object files.
    temp = change_type(source, ".s")
    object = change_type(source, ".o")
    list   = @options[:list] ? "-l " + change_type(source, ".lst") : ""
    command = "ca65 #{target}#{list} -o #{object} #{temp} #{@quiet}\n"
    puts command if @options[:debug]
    system(command)
    fail "Error assembling #{source.localize_path}" unless $?.exitstatus == 0

    @options[:temps] << temp
    @options[:objs] << object
  end

end
