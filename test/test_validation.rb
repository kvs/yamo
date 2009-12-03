require 'helper'

class TestValidation < Test::Unit::TestCase
  def test_load
    CollectionTest.objectdir "#{TESTDIR}/data/collection_bogus"
    assert_raise Yamo::ValidateError do
      CollectionTest.entries
    end

    assert_raise Yamo::ValidateError do
      CollectionTest.schema "#{TESTDIR}/data/schemas/collection_bogus.yaml"
    end
  end
end
