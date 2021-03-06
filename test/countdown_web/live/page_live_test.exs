defmodule CountdownWeb.PageLiveTest do
  use CountdownWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to Countdown!"
    assert render(page_live) =~ "Welcome to Countdown!"
  end
end
