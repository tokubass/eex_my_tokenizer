Code.require_file("test_helper.exs", __DIR__)

defmodule EEx.MyTokenizerTest do
  use ExUnit.Case, async: true
  require EEx.MyTokenizer, as: T

  test "simple chars lists" do
    assert T.tokenize('foo', 1) == {:ok, [{:text, 'foo'}]}
  end

  # commentから実装することで、まずexprを取得するだけのコードがかける(exprを取得しても処理せず捨てるだけ)
  test 'comment <%#' do
    assert T.tokenize('<%# expr! %>', 1) == {:ok, []}
    assert T.tokenize('foo<%# expr! %>', 1) == {:ok, [{:text, 'foo'}]}
    assert T.tokenize('foo1<%# expr! %>foo2', 1) == {:ok, [{:text, 'foo1'},{:text, 'foo2'}]}
  end


  # 次に:text以外のtokenを処理できるようにする。
  test 'simple :expr' do
    assert T.tokenize('<% var %>' ,1)  == {:ok, [{:expr, '',  ' var ' }]}
    assert T.tokenize('<%= var %>',1)  == {:ok, [{:expr, '=', ' var ' }]}
  end

end
