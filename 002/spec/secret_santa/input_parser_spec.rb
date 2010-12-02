require 'spec_helper'

describe SecretSanta::InputParser do
  describe '#parse' do
    it 'should parse the string into a Person' do
      person = subject.parse 'Luke Skywalker   <luke@theforce.net>'

      person.values.should == ['Luke', 'Skywalker', 'luke@theforce.net']
    end
  end
end
