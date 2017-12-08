defmodule EEx.MyTokenizer do
  @moduledoc false


  @type content :: IO.charlist
  @type token :: { :text, content }

  
  @doc """
  Tokenizes the given charlist or binary.

  It returns {:ok, list} with the following tokens:

    * `{:text, content}`
    * `{:expr, line, marker, content}`
    * `{:start_expr, line, marker, content}`
    * `{:middle_expr, line, marker, content}`
    * `{:end_expr, line, marker, content}`

  Or `{:error, line, error}` in case of errors.
  """

  def tokenize(chars,line) when is_integer(line) do
    buffer = []
    acc = []
    tokenize(chars,buffer, acc)
  end

  def tokenize('<%#' ++ t, buffer, acc) do
    acc = tokenize_text(buffer,acc)
    buffer = []
    t = case get_expr(t, buffer) do # %>まで進める
          {:ok, _buffer, rest}
            ->  rest
          _
            -> raise 'not match %>'
        end

    tokenize(t,buffer,acc) # %> -> <% or text(空文字も含む)
  end

  def tokenize('<%' ++ t, buffer, acc) do
    
  end

  def tokenize([h|t],buffer,acc) do #　一文字ずつ削るだけの汎用関数
      tokenize(t, [ h | buffer], acc)
  end

  def tokenize([],buffer,acc) do # text(空文字) -> EOF
    acc = tokenize_text(buffer,acc)
    {:ok, Enum.reverse(acc) }
  end

  def token_name(expr) do
    
  end

  def tokenize_text([],acc) do
    acc
  end
  def tokenize_text(buffer,acc) do
    [ {:text, Enum.reverse(buffer) } | acc ]
  end

  def get_expr('%>' ++ t, buffer) do
    {:ok, buffer, t}
  end
  def get_expr([h|t], buffer) do
    get_expr(t, [ h | buffer])
  end
  
end
