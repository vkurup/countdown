# Countdown

To start your Phoenix server:

  * Complete local dev setup (see below)
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Local dev setup

We use [pre-commit](https://pre-commit.com/) to format and test our code.

You can also make local configurations which won't go into version control. As an
example, if you want the app to connect to Postgresql via unix domain sockets, add this
to `config/dev.secret.exs`:

```
import Config

config :countdown, Countdown.Repo,
  socket_dir: "/var/run/postgresql",
```

To run the Phoenix server, while also having a command line to inspect stuff:

```
iex -S mix phx.server
```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
