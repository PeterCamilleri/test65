# An enclosure for the ca65 assembler.

class TestScript

  # Add some include paths for the assembler.
  def ca65_paths(*more_paths)
    fail "Sequence error" unless @phase == :create
    (@options[:ca65_paths] << more_paths).flatten!
  end

  # Assemble some files.
  def ca65(*more_files)
    fail "Sequence error" unless @phase == :create

    sources = (@options[:asm_src] + more_files).flatten
    @options[:asm_src] = []
    paths   = build_args("-I", @options[:ca65_paths])
    target  = "--target #{@options[:target]} "
    quiet   = @options[:quiet].to_s

    # Convert source assemble files into object files.
    source_files.each do |source|
      object = "-o " + change_type(source, ".o")
      list   = @options[:list] ? "-l " + change_type(source, ".lst") : ""
      system("ca65 #{target} #{paths} #{list} #{object} #{source} #{quiet}\n")
      fail "Error assembling #{localize_path(source)}" unless $?.exitstatus == 0

      @options[:objs] << object
    end

    # Reset back to default paths.
    @options[:ca65_paths] = ["#{@options[:gem_root]}/asminc"]
  end

end
