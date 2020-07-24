# An enclosure for the ca65 assembler.
class TestScript

  # Setup ca65
  def ca65_initialize
    @options[:ca65_target] = "sim65c02"
    @options[:ca65_inc_paths] = ["#{@options[:gem_root]}/asminc"]
    @options[:objs] = []
  end

  # Add some include paths for the assembler.
  def ca65_inc_paths(*more_paths)
    fail "Sequence error: ca65_inc_paths" unless @phase == :create
    append_option(:ca65_inc_paths, more_paths)
  end

  # Assemble some files.
  def ca65(file, options="")
    fail "Sequence error: ca65" unless @phase == :create
    source  = File.absolute_path(@options[:path] + "/" + file)
    target  = "--target #{@options[:ca65_target]} "
    paths   = build_args("-I", @options[:ca65_inc_paths])

    # Convert source assemble files into object files.
    object = change_type(source, ".o")
    list   = @options[:list] ? "-l " + change_type(source, ".lst") : ""
    command = "ca65 #{target}#{paths}#{list}#{options} -o #{object} #{source} #{@quiet}\n"
    puts command if @options[:debug]
    system(command)
    fail "Error assembling #{source.localize_path}" unless $?.exitstatus == 0

    @options[:objs] << object
  end

end
