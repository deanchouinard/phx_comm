defmodule MyChannel do
  use PhoenixChannelClient

  def handle_in("new_msg", %{"body" => body} = payload, state) do
    IO.puts("Handle in: #{body}")
    {:noreply, state}
  end  

  def handle_reply({:ok, "new_msg", resp, _ref}, state) do
    {:noreply, state}
  end
  def handle_reply({:error, "new_msg", resp, _ref}, state) do
    {:noreply, state}
  end
  def handle_reply({:timeout, "new_msg", _ref}, state) do
    {:noreply, state}
  end

  def handle_reply({:timeout, :join, _ref}, state) do
    {:noreply, state}
  end

  def handle_reply({:ok, :join, resp, _ref}, state) do
    {:noreply, state}
  end

  def handle_close(reason, state) do
    Process.send_after(self(), :rejoin, 5_000)
    {:noreply, state}
  end
end
