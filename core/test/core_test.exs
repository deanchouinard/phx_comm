defmodule CoreTest do
  use ExUnit.Case
  doctest Core

  test "greets the world" do
    assert Core.hello() == :world
  end

  # these tests aren't really communicating across the apps...
  # - should use the web interface
  #
  test "use Genserver function call" do
    # Core.Worker.push("hello")
    # assert Core.Worker.pop() == "hello"

    assert UI.Sensor.get_temp() == 75
  end
  
  test "use registry" do
    assert UI.Sensor.get_humid() == 55

    # [{eserver, _}] = Registry.lookup(:my_registry, {EchoServer, "server one"})
    # send(eserver, {:hello, self()})
    # dmsg = receive do
    #   msg -> msg
    # after
    #   5000 ->
    #   IO.puts :stderr, "No message in 5 seconds"
    # end
    # assert dmsg == :world
  end

end
