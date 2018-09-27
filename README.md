# phx_comm
Trying different ways to communicate between an app and Phoenix in a 
[poncho project](https://embedded-elixir.com/post/2017-05-19-poncho-projects/)
environment. Trying to
simulate a Nerves firmware app communicating with a Phoenix web server on a device.

There are two apps: `:core`, which is simulating a Nerves firmware app; and, `:ui`, which is the Phoenix
web server. In this scenario you are controlling a device via a web interface.

## To run the code:

    $ cd core
    $ mix test

## Strategies

### 1. Just call a function
Simply calls a function in a module. Since the module is in a different app, you will get compiler
warnings. But since the GenServer module is in memory at runtime the function calls will work. You
can use the `xref: :exclude` config setting to suppress the warnings.

### 2. Register a process and send/receive messages
Use the Registry `via:` capability to register a GenServer and use `send and receive` to
communicate between the apps with messages.

### 3. Phoenix Channels
To get phoenix_channel_client working the channel set up in the Phoenix guides chat
application:
* add {:websocket_client, "~> 1.3"}
* add to MyChannel:
```elixir
  def handle_reply({:ok, :join, resp, _ref}, state) do
    {:noreply, state}
  end
```
* make sure correct app name in MySocket
* in config, set token to ""
* don't send any params: in MySocket.start_link(params: %{})
* 
```elixir
{:ok, socket} = MySocket.start_link(params: %{})
{:ok, channel} = PhoenixChannelClient.channel(MyChannel, socket: MySocket, topic: "room:lobby")
MyChannel.join(%{})
push = MyChannel.push("new_msg", %{body: "hello from nerves"})
```
# xtra
Do GFM tasks work here:

- [x] completed taks
- [ ] incomplete task
- [ ] another


