require 'secret_santa'

rcfile = File.join(ENV['HOME'], '.santarc')
if ! File.exists?(rcfile)
  STDERR.print <<USAGE
You must have a .santarc file in your home directory!
It should look like this:
---
  :address: smtp.gmail.com
  :port: 587
  :user_name: <username>
  :password: <password>
  :authentication: :plain
USAGE
  exit
end

settings = YAML.load(File.open(rcfile))

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = settings
ActionMailer::Base.default :from => settings[:user_name]

SecretSanta::CLI.new.run
