require "test/unit"
require_relative './solution'

class TestSolution < Test::Unit::TestCase
  # tag::split[]
  def test_split_to_layers
    input = "123456789012"
    result = [
      ["123", "456"],
      ["789", "012"]
    ]
    assert_equal result, split_to_layers(input, 3, 2)
  end
  # end::split[]
end
