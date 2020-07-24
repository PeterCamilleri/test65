require_relative '../lib/test65'
require          'minitest/autorun'

class Test65Test < Minitest::Test

  def test_that_cc65_is_hooked_up
    assert(ENV["path"]["cc65"], "cc65 is not in the path.")
    assert(ENV["CC65_HOME"], "Environment variable CC65_HOME is not set.")
  end

  def test_that_it_has_a_version_number
    refute_nil(::Test65::VERSION)
    assert(::Test65::VERSION.frozen?)
    assert(::Test65::VERSION.is_a?(String))
    assert(/\A\d+\.\d+\.\d+/ =~ ::Test65::VERSION)
  end

  def test_that_it_has_a_description
    refute_nil(::Test65::DESCRIPTION)
    assert(::Test65::DESCRIPTION.frozen?)
    assert(::Test65::DESCRIPTION.is_a?(String))
  end

  def test_that_help_works
    system "ruby exe/test65 -? > foo\n"
    assert_equal(0, $?.exitstatus)
    system "rm foo\n"
  end

  def test_that_the_default_test_works
    system "ruby exe/test65 -v > foo\n"
    assert_equal(0, $?.exitstatus)
    system "rm foo\n"
  end

  def test_that_it_traps_bad_files
    system "ruby exe/test65 xyzzy > foo\n"
    assert_equal(1, $?.exitstatus)
    system "rm foo\n"
  end

  def test_that_it_traps_bad_paths
    system "ruby exe/test65 -p xyzzy > foo\n"
    assert_equal(1, $?.exitstatus)
    system "rm foo\n"
  end

  def test_that_it_succeeds
    system "ruby exe/test65 min_pass.a65 > foo\n"
    assert_equal(0, $?.exitstatus)

    system "ruby exe/test65 min_pass2.rb > foo\n"
    assert_equal(0, $?.exitstatus)

    system "rm foo\n"
  end

  def test_that_it_succeeds_in_c
    system "ruby exe/test65 min_pass_c.c65 > foo\n"
    assert_equal(0, $?.exitstatus)

    system "ruby exe/test65 min_pass2_c.rb > foo\n"
    assert_equal(0, $?.exitstatus)

    system "rm foo\n"
  end

  def test_that_it_fails
    system "ruby exe/test65 min_fail.a65 > foo\n"
    assert_equal(1, $?.exitstatus)

    system "ruby exe/test65 min_fail2.rb > foo\n"
    assert_equal(1, $?.exitstatus)

    system "rm foo\n"
  end

  def test_that_it_fails_in_c
    system "ruby exe/test65 min_fail.c65 > foo\n"
    assert_equal(1, $?.exitstatus)

    system "ruby exe/test65 min_fail2_c.rb > foo\n"
    assert_equal(1, $?.exitstatus)

    system "rm foo\n"
  end

  def test_that_it_handles_asm_errors
    system "ruby exe/test65 -q asm_err.a65 > foo\n"
    assert_equal(1, $?.exitstatus)
    system "rm foo\n"
  end

  def test_that_it_handles_c_errors
    system "ruby exe/test65 -q c_err.a65 > foo\n"
    assert_equal(1, $?.exitstatus)
    system "rm foo\n"
  end

  def test_that_it_handles_linker_errors
    system "ruby exe/test65 -q linker_err.a65 > foo\n"
    assert_equal(1, $?.exitstatus)
    system "rm foo\n"
  end

  def test_that_it_supports_the_test_include
    system "ruby exe/test65 pass.a65 > foo\n"
    assert_equal(0, $?.exitstatus)
    system "rm foo\n"
  end

  def test_that_it_handles_macro_errors
    system "ruby exe/test65 -q macro_err1.a65 > foo\n"
    assert_equal(1, $?.exitstatus)
    system "rm foo\n"
  end

  def test_that_it_handles_other_macro_errors
    system "ruby exe/test65 -q macro_err2.a65 > foo\n"
    assert_equal(1, $?.exitstatus)
    system "rm foo\n"
  end

  def test_that_it_handles_wild_cards
    system "ruby exe/test65 -q *pass.a65 > foo\n"
    assert_equal(0, $?.exitstatus)
    system "rm foo\n"
  end

end
