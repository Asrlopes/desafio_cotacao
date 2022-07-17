import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :desafio_cotacao, DesafioCotacaoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "zS/mJpqemjYZFuMVxSb6seUsP9B1zvpa7m8pHBvWQV9XoBq5aRdbKSLiN+aTF+/z",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
