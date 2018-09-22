# Core
Trying different ways to communicate between a poncho "app" and Phoenix.

Simulating a Nerves project.

    $ mix test

1. Just call a function
Calls a module. Get compile errors, but the GenServer is in memory at runtime
and the calls work.

2. Register a process and send/receive messages

3. Phoenix Channels
To get phoenix_channel_client working the channel set up in the Phoenix guides chat
application:
* add {:websocket_client, "~> 1.3"}
* add to MyChannel:
```
  def handle_reply({:ok, :join, resp, _ref}, state) do
    {:noreply, state}
  end
```
* make sure correct app name in MySocket
* in config, set token to ""
* don't send any params: in MySocket.start_link(params: %{})
* 
```
iex(1)> {:ok, socket} = MySocket.start_link(params: %{})
iex(2)> {:ok, channel} = PhoenixChannelClient.channel(MyChannel, socket: MySocket, topic: "room:lobby")
iex(3)> MyChannel.join(%{})
iex(4)> push = MyChannel.push("new_msg", %{body: "hello from nerves"})
```

