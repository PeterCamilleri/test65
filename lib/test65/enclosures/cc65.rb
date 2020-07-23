# An enclosure for the cc65 compiler.
class TestScript

  # Setup ca65
  def cc65_initialize
    @options[:cc65_target] = "sim65c02"
    @options[:cc65_paths] = ["#{@options[:gem_root]}/include"]
    @options[:objs] = []
  end

  # Add some include paths for the assembler.
  def cc65_inc_paths(*more_paths)
    fail "Sequence error: ca65_inc_paths" unless @phase == :create
    append_option(:inc_paths, more_paths)
  end

  # Assemble some files.
  def cc65(file, options="")
    fail "Sequence error: cc65" unless @phase == :create
    source  = File.absolute_path(@options[:path] + "/" + file)
    target  = "--target #{@options[:cc65_target]} "
    paths   = build_args("-I", @options[:cc65_paths])

    # Convert source assemble files into object files.
    object = change_type(source, ".o")
    command = "cc65 #{target}#{paths}#{options} -o #{object} #{source} #{@quiet}\n"
    puts command if @options[:debug]
    system(command)
    fail "Error assembling #{source.localize_path}" unless $?.exitstatus == 0

    @options[:objs] << object
  end

end
