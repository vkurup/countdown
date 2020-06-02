defmodule CountdownWeb.PageLive do
  @moduledoc """
  LiveView page for the Countdown timer.
  """

  use CountdownWeb, :live_view

  @timer_length 25 * 60

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, time_remaining: @timer_length, is_running: false, is_done: false)}
  end

  @impl true
  def handle_event("start", _value, %{assigns: %{is_running: false}} = socket) do
    new_socket =
      socket
      |> assign(is_running: true, is_done: false)
      |> schedule_tick()
      |> put_flash(:info, "Timer started.")

    {:noreply, new_socket}
  end

  @impl true
  def handle_event("change", %{"timer_length" => ""}, socket) do
    {:noreply, assign(socket, time_remaining: 1)}
  end

  @impl true
  def handle_event("change", %{"timer_length" => timer_length}, socket) do
    {:noreply, assign(socket, time_remaining: String.to_integer(timer_length) * 60)}
  end

  @impl true
  def handle_event("start", _value, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("pause", _value, socket) do
    new_socket =
      socket
      |> assign(is_running: false)
      |> put_flash(:info, "Timer paused.")

    {:noreply, new_socket}
  end

  @impl true
  def handle_event("reset", _value, socket) do
    new_socket =
      socket
      |> reset_timer()
      |> put_flash(:info, "Timer reset.")

    {:noreply, new_socket}
  end

  @impl true
  def handle_info(:tick, %{assigns: %{is_running: false}} = socket) do
    # ignore tick if timer is not running
    {:noreply, socket}
  end

  @impl true
  def handle_info(:tick, %{assigns: %{time_remaining: 1}} = socket) do
    # we're at the final second, mark timer done!
    new_socket =
      socket
      |> assign(is_done: true)
      |> reset_timer()
      |> clear_flash()

    {:noreply, new_socket}
  end

  @impl true
  def handle_info(:tick, socket) do
    # decrement the timer by a second
    new_socket =
      socket
      |> update(:time_remaining, &(&1 - 1))
      |> schedule_tick()

    {:noreply, new_socket}
  end

  defp minutes(time_remaining) do
    # Helper function to calculate minutes from total seconds.
    div(time_remaining, 60)
  end

  defp seconds(time_remaining) do
    # Helper function to calculate seconds from total seconds, and zero-pad it
    time_remaining
    |> rem(60)
    |> to_string
    |> String.pad_leading(2, "0")
  end

  defp reset_timer(socket) do
    assign(socket, time_remaining: @timer_length, is_running: false)
  end

  defp schedule_tick(socket) do
    Process.send_after(self(), :tick, 1000)
    assign(socket, is_running: true)
  end
end
