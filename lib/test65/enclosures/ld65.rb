# An enclosure for the ld65 linker.

class TestScript

  # Add some library paths for the linker.
  def ld65_lib_paths(*more_paths)
    fail "Sequence error: ld65_lib_paths" unless [:create, :link].include?(@phase)
    append_option(:lib_paths, more_paths)
    @phase = :link
  end

  # Add some library paths for the linker.
  def ld65_libraries(*more_libs)
    fail "Sequence error: ld65_libraries" unless [:create, :link].include?(@phase)
    append_option(:lib_paths, more_libs)
    @phase = :link
  end

  def ld65_options(*more_options)
    fail "Sequence error: ld65_options" unless [:create, :link].include?(@phase)
    append_option(:ld65_options, more_options)
    @phase = :link
  end

  def ld65
    fail "Sequence error: ld65" unless [:create, :link].include?(@phase)
    @phase = :simulate

    @target   = change_type(@options[:objs][0], ".out")
    lib_paths = build_args("--lib-path", @options[:lib_paths])
    objs      = build_args(@options[:objs])
    libs      = build_args("--lib", @options[:libraries])
    opts      = build_args(@options[:ld65_options])
    map       = @options[:map] ? "-m #{@mapping}" : ""
    cfg       = "-C #{@gem_root}/cfg/test65.cfg"

    system("ld65 #{libs} #{cfg} #{@objs} #{map} -o #{@target} #{@quiet}\n")
    fail "Error linking #{localize_path(@target)}." unless $?.exitstatus == 0
  end

end
