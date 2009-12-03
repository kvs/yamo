require 'helper'

class TestSingleton < Test::Unit::TestCase
  def test_load
    assert_equal(8, SingletonTest.instance.a.b)
    assert_equal(3, SingletonTest.instance.a.f.count)
  end
end
