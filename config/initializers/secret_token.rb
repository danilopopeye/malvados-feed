# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
MalvadosFeed::Application.config.secret_key_base = ENV['secret_key_base'] || '414cbbc9e2f1b82246a1e1ab99b359be3768efc1fb6955a9eab99338a350a4a9b1d4d69f1829cbc377441d7422f9bc31814c5d6d1b9d9ad30a8889912d170102'
