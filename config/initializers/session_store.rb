# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_railsmg_session',
  :secret      => 'dfde05570f361b7cd5f68ba862cd32ff771346ad00de30608a770ffcba0d66dac53552f88db40be749f0c16b50320a80b384fe432adff8ba79517088d2cc2a6c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
