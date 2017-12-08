Code.require_file("test_helper.exs", __DIR__)

defmodule EEx.MyTokenizerTest do
  use ExUnit.Case, async: true
  require EEx.MyTokenizer, as: T

  test "simple chars lists" do
    assert T.tokenize('foo', 1) == {:ok, [{:text, 'foo'}]}
#    assert T.tokenize('foo<%# expr! %>', 1) == {:ok, [{:text, 'foo'}]}
  end

end
