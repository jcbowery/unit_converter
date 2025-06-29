import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :unit_converter, UnitConverterWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "pW1b9tGQK4zfw3yCS7Vkqu2H4HxYVQdY9sSW67nVUzRvzjTnum5j33NjbbByVlCY",
  server: false

# In test we don't send emails
config :unit_converter, UnitConverter.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

config :unit_converter, UnitConverterWeb.Endpoint,
  http: [port: 4002],
  server: true

config :unit_converter, :sql_sandbox, true

config :wallaby, driver: Wallaby.Chrome
config :wallaby, screenshot_dir: "screenshots"
config :wallaby, screenshot_on_failure: true
