require 'machinist/active_record'

User.blueprint do
  name               'Gabriel Sobrinho'
  github             'sobrinho'
  email              'gabriel@example.com'
  password           { '123456' }
  password_salt      { Authlogic::Random.hex_token }
  crypted_password   { Authlogic::CryptoProviders::Sha512.encrypt(password + password_salt) }
  persistence_token  { Authlogic::Random.hex_token }
  perishable_token   { Authlogic::Random.friendly_token }
end

