# An enclosure for the ld65 linker.

class TestScript

  # Setup ld65
  def ld65_initialize
    @options[:lib_paths] = []
    @options[:libraries] = ["sim65c02.lib"]
    @options[:ld65_options] = []
    @options[:config] = "#{@options[:gem_root]}/cfg/test65.cfg"
  end

  # Add some library paths for the linker.
  def ld65_lib_paths(*more_paths)
    fail "Sequence error: ld65_lib_paths" unless [:create, :link].include?(@phase)
    append_option(:lib_paths, more_paths)
    @phase = :link
  end

  # Add some library paths for the linker.
  def ld65_libraries(*more_libs)
    fail "Sequence error: ld65_libraries" unless [:create, :link].include?(@phase)
    append_option(:libraries, more_libs)
    @phase = :link
  end

  def ld65(options="")
    fail "Sequence error: ld65" unless [:create, :link].include?(@phase)
    @phase = :simulate

    @output   = change_type(@options[:objs][0], ".out")
    @map_file = change_type(@options[:objs][0], ".map")
    lib_paths = build_args("--lib-path", @options[:lib_paths])
    objs      = build_args(@options[:objs])
    libs      = build_args("--lib", @options[:libraries])
    map       = @options[:map] ? "-m #{@map_file}" : ""
    cfg       = "-C " + @options[:config] + " "

    # Build the command and run it.
    command = "ld65 #{lib_paths}#{libs}#{cfg}#{options} #{objs}#{map} -o #{@output} #{@quiet}\n"
    puts command if @options[:debug]
    system(command)
    fail "Error linking #{@output.localize_path}." unless $?.exitstatus == 0
  end

end
