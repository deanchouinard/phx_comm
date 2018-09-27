defmodule UI.Sensor do

  def get_temp do

    # Core.Worker.push("hello")
    #
    # IO.puts Core.Worker.pop()
    # IO.inspect Registry.lookup(Registry.ViaTest, "hello")

    Core.Worker.get_temp()
  end

  def get_humid do

    [{eserver, _}] = Registry.lookup(:my_registry, {EchoServer, "server one"})
    send(eserver, {:humid, self()})
    humid = receive do
      msg -> msg
    after
      5000 ->
      IO.puts :stderr, "No message in 5 seconds"
    end
    humid
  end
end

