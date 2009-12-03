require 'helper'

class TestCollection < Test::Unit::TestCase
  def test_load
    assert_equal(2, CollectionTest.entries.count)
    assert_equal('obj1', CollectionTest.get("obj1").name)
    assert_equal(1, CollectionTest.find_all { |c| c.d == "Bar" }.count)
    obj = CollectionTest.entries.first
    assert_equal(true, obj.b.b)
  end
end
