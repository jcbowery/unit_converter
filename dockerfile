# Step 1: Build stage
FROM hexpm/elixir:1.18.2-erlang-27.3-alpine-3.18.9 AS build

# Install build dependencies
RUN apk add --no-cache build-base npm git

# Set working directory
WORKDIR /app

# Cache elixir deps
COPY mix.exs mix.lock ./
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get --only prod && \
    mix deps.compile

# Copy the rest of the project files
COPY . .

# Compile assets if you have any (skip if no assets)
# RUN npm install --prefix ./assets
# RUN npm run deploy --prefix ./assets
# RUN mix phx.digest

# Compile the release
RUN MIX_ENV=prod mix compile
RUN MIX_ENV=prod mix phx.digest
RUN MIX_ENV=prod mix release

# Step 2: Release image
FROM alpine:3.18 AS app

RUN apk add --no-cache libgcc libstdc++ openssl ncurses-libs

WORKDIR /app

# Copy release from build stage
COPY --from=build /app/_build/prod/rel/unit_converter ./

ENV REPLACE_OS_VARS=true \
    MIX_ENV=prod \
    LANG=C.UTF-8

# Expose default Phoenix port
EXPOSE 4000

# Start the Phoenix app
CMD ["./bin/unit_converter", "start"]
