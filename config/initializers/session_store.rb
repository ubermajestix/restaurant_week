# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_restaurantweek2010_session',
  :secret      => 'f256935dc0283fb4069efbfeb2664e0f09f263734f9a567c1890620bfc0595695b513a48e7351fad706c537d2e57b703f002a1a62bdccb33090c20461ce4a624'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
