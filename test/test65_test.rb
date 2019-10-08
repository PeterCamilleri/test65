require_relative '../lib/test65'
require          'minitest/autorun'
require          'minitest_visible'

class Test65Test < Minitest::Test
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

end
