# An enclosure for the sim65 simulator.

class TestScript

  # Setup sim65
  def sim65_initialize
    @options[:sim65_options] = []
  end

  # Run the simulator to get the actual test results.
  def sim65(options="")
    fail "Sequence error: sim65" unless @phase == :simulate
    @phase = :done

    # Build the command and run it.
    command = "sim65 #{options} #{@output} #{@quiet}\n"
    puts command if @options[:debug]
    system(command)
    status = $?.exitstatus
    fail "Test #{@output.localize_path} failed with error code: #{status}" unless status == 0
  end

end
