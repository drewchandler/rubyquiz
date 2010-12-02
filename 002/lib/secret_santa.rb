require 'secret_santa/generator'
require 'secret_santa/input_parser'
require 'secret_santa/mailer'

module SecretSanta
  Person = Struct.new(:first_name, :last_name, :email_address)
end
