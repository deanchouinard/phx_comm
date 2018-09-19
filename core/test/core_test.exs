defmodule CoreTest do
  use ExUnit.Case
  doctest Core

  test "greets the world" do
    assert Core.hello() == :world
  end

  test "use registry" do
    [{eserver, _}] = Registry.lookup(:my_registry, {EchoServer, "server one"})
    send(eserver, {:hello, self()})
    dmsg = receive do
      msg -> msg
    after
      5000 ->
      IO.puts :stderr, "No message in 5 seconds"
    end
    assert dmsg == :world
  end

end
