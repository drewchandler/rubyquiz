require 'action_mailer'

module SecretSanta
  class Mailer < ActionMailer::Base
    def santa_msg(santa, santee)
      mail(
        :to => santa.email_address,
        :subject => 'Your Secret Santa Assignment!',
        :body => "You need to buy a gift for #{santee.first_name} #{santee.last_name}!"
      )
    end
  end
end
