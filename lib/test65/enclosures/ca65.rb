# An enclosure for the ca65 assembler.
class TestScript

  # Add some include paths for the assembler.
  def ca65_inc_paths(*more_paths)
    fail "Sequence error: ca65_inc_paths" unless @phase == :create
    append_option(:inc_paths, more_paths)
  end

  def ca65_options(*more_options)
    fail "Sequence error: ca65_options" unless @phase == :create
    append_option(:ca65_options, more_options)
  end

  # Assemble some files.
  def ca65(*more_files)
    fail "Sequence error: ca65" unless @phase == :create
    sources = (@options[:asm_src] + more_files).flatten
    @options[:asm_src] = []
    target  = "--target #{@options[:target]} "
    paths   = build_args("-I", @options[:ca65_paths])
    options = build_args(@options[:ca65_options])

    # Convert source assemble files into object files.
    source_files.each do |source|
      object = "-o " + change_type(source, ".o")
      list   = @options[:list] ? "-l " + change_type(source, ".lst") : ""
      system("ca65 #{target} #{paths} #{list} #{options} #{object} #{source} #{@quiet}\n")
      fail "Error assembling #{localize_path(source)}" unless $?.exitstatus == 0

      @options[:objs] << object
    end

    # Reset back to defaults.
    @options[:ca65_paths] = ["#{@options[:gem_root]}/asminc"]
    @options[:ca65_options] = []
  end

end
