defmodule CoreTest do
  use ExUnit.Case, async: false
  doctest Core

  defmodule ClientChannel do
    use PhoenixChannelClient
    require Logger

    def handle_in(event, payload, state) do
      send(state.opts[:caller], {event, payload})
      {:noreply, state}
    end

    def handle_reply(payload, state) do
      send(state.opts[:caller], payload)
      {:noreply, state}
    end

    def handle_close(payload, state) do
      send(state.opts[:caller], {:closed, payload})
      send(self(), :reconnect)
      {:noreply, state}
    end
  end

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

  test "use channels" do
    # push = MyChannel.push("new_msg", %{body: "hello from nerves"})
    # IO.inspect push
    # IO.inspect self()
    #
    # assert_receive {"new_msg", %{"body" => "hello from nerves"}}

    {:ok, _channel} =
      ClientChannel.start_link(socket: MySocket, topic: "rooms:admin-lobby", caller: self())

    %{ref: ref} = ClientChannel.join()
    assert_receive {:ok, :join, _, ^ref}
    ClientChannel.push("new_msg", %{test: :test})
    assert_receive {"new_msg", %{"test" => "test"}}
  end

end
