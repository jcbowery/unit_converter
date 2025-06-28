# unit_converter
a simple webapp with no crud. Used to Demo elixir testing and building a docker image

## Setting Up Project After Pull
1. Run setup_hooks script

## Start Project
To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Running Docker Image
```
sudo docker run \
  -e PHX_SERVER=true \
  -e SECRET_KEY_BASE=$(mix phx.gen.secret) \
  -e PHX_HOST=localhost \
  -e PORT=4000 \
  -p 4000:4000 \
  unit_converter:0.0.1
```
