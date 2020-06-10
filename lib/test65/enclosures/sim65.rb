# An enclosure for the sim65 simulator.

class TestScript

  def sim65_options(*more_options)
    fail "Sequence error: ld65_options" unless @phase == :simulate
    append_option(:sim65_options, more_options)
    @phase = :link
  end

  # Run the simulator to get the actual test results.
  def sim65
    fail "Sequence error: sim65" unless @phase == :simulate
    @phase == :done

    opts = build_args(@options[:sim65_options)
    system("sim65 #{opts} #{@target}\n")
    status = $?.exitstatus
    fail "Test #{localize_path(@target)} failed with error code: #{status}" unless status == 0
  end

end
