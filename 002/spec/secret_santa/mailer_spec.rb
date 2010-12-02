require 'spec_helper'

describe SecretSanta::Mailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries.clear
  end

  describe '.santa_msg' do
    let(:joe)  { SecretSanta::Person.new('Joe', 'Blow', 'joe.blow@gmail.com') }
    let(:john) { SecretSanta::Person.new('John', 'Doe', 'john.doe@gmail.com') }

    subject { SecretSanta::Mailer.santa_msg(joe, john) }

    it 'should send a message to the secret santa' do
      subject.to.should == [joe.email_address]
    end
    
    it 'should have a snazzy subject' do
      subject.subject.should == 'Your Secret Santa Assignment!'
    end

    it 'should have a body telling the secret santa who they need to buy a gift for' do
      subject.body.to_s.should == 'You need to buy a gift for John Doe!'
    end
  end
end
