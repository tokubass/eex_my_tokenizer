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
    # ここでmarker初登場。すでに実装した<% var %>にもmarker対応させる
    assert T.tokenize('<%= var %>',1)  == {:ok, [{:expr, '=', ' var ' }]}
  end

  test ':expr + :text' do
    assert T.tokenize('foo<% var %>bar',1)  == {:ok, [{:text, 'foo'}, {:expr, '', ' var ' }, {:text, 'bar'}]}
    assert T.tokenize('foo<%= var %>bar',1)  == {:ok, [{:text, 'foo'}, {:expr, '=', ' var ' }, {:text, 'bar'}]}
  end

  ## <%%を作ってもいいが面白くないのでif文にとりかかる
  
end
