require 'machinist/active_record'

User.blueprint do
  name              'Gabriel Sobrinho'
  email             'gabriel@example.com'
  city              'Belo Horizonte'
  password          { '123456' }
  password_salt     { Authlogic::Random.hex_token }
  crypted_password  { Authlogic::CryptoProviders::Sha512.encrypt(password + password_salt) }
  persistence_token { Authlogic::Random.hex_token }
  perishable_token  { Authlogic::Random.friendly_token }
end

Project.blueprint do
  user        { User.make }
  name        'Example project'
  description 'An example project'
end

Meeting.blueprint do
  user        { User.make }
  name        'Meeting example'
  description 'An example of meeting'
end