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

  def test_merge_layers
    input = "0222112222120000"
    layers = split_to_layers(input, 2, 2)
    result = ["01", "10"]
    assert_equal result, merge_layers(layers)
  end
end
