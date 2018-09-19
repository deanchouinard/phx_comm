defmodule EchoServer do
  use GenServer
  def start_link(id) do
    GenServer.start_link(__MODULE__, nil, name: via_tuple(id))
  end
  def init(args) do
    IO.puts "EchoServer args: #{args}"
    {:ok, args}
  end
  def call(id, some_request) do
    GenServer.call(via_tuple(id), some_request)
  end
  defp via_tuple(id) do
    {:via, Registry, {:my_registry, {__MODULE__, id}}}
  end
  def handle_call(some_request, _, state) do
    {:reply, some_request, state}
  end

  def handle_info({:hello, pid}, state) do
    IO.puts "hello info"
    send(pid, :world)
    {:noreply, state}
  end

  # @impl GenServer
  #def handle_call(some_request, server_state) do
  # {:reply, some_request, server_state}
  #end
end
