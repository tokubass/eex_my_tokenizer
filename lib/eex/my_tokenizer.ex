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

  def tokenize([h|t],buffer,acc) do
      tokenize(t, [ h | buffer], acc)
  end

  def tokenize([],buffer,acc) do # text -> EOF
    
    {:ok, [ {:text, Enum.reverse(buffer) } | acc ] }
    
  end

  def token_name(expr) do
    
  end
  
end
