defmodule Core.Worker do
  use GenServer
  
  def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default, name: CW)
  end

  def push(item) do
    GenServer.cast(CW, {:push, item})
  end

  def pop() do
    GenServer.call(CW, :pop)
  end

  # Server (callbacks)

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_cast({:push, item}, state) do
    {:noreply, [item | state]}
  end

end

