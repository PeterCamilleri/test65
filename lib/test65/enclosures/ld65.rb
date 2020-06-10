# An enclosure for the ld65 linker.

class TestScript

  def ld65
    fail "Sequence error: ld65" unless [:create, :link].include?(@phase)
    @phase = :simulate

    @target   = change_type(@options[:objs][0], ".out")
    lib_paths = build_args("--lib-path", @options[:objs])
    libs      = build_args("--lib", @options[:objs])
    objs      = build_args(@options[:objs])

  end

end
