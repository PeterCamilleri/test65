# An enclosure for the sim65 simulator.

class TestScript

  # Setup sim65
  def sim65_initialize
    @options[:sim65_options] = []
  end

  def sim65_options(*more_options)
    fail "Sequence error: ld65_options" unless @phase == :simulate
    append_option(:sim65_options, more_options)
    @phase = :link
  end

  # Run the simulator to get the actual test results.
  def sim65
    fail "Sequence error: sim65" unless @phase == :simulate
    @phase = :done

    opts = build_args(@options[:sim65_options])

    # Build the command and run it.
    command = "sim65 #{opts}#{@output} #{@quiet}\n"
    puts command if @options[:debug]
    system(command)
    status = $?.exitstatus
    fail "Test #{@output.localize_path} failed with error code: #{status}" unless status == 0
  end

end
