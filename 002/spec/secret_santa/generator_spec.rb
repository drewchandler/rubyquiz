require 'spec_helper'

describe SecretSanta::Generator do
  subject { SecretSanta::Generator.new people }

  let(:joe)  { SecretSanta::Person.new('Joe', 'Blow', 'joe.blow@gmail.com') }
  let(:john) { SecretSanta::Person.new('John', 'Doe', 'john.doe@gmail.com') }
  let(:jane) { SecretSanta::Person.new('Jane', 'Doe', 'jane.doe@gmail.com') }
  let(:jim) { SecretSanta::Person.new('Jim', 'Smith', 'jane.doe@gmail.com') }
  let(:people) { [ joe, john, jane, jim ] }

  describe '#generate_santas' do
    it 'should find a secret santa for each person' do
      people.stub(:shuffle).and_return([ john, jim, joe, jane,])

      subject.generate_santas.should == [
        [ joe,  john ],
        [ john, jim  ],
        [ jane, joe  ],
        [ jim, jane  ],
      ]
    end

    it 'should not allow a person to have a person with the same last name be their secret santa' do
      people.stub(:shuffle).and_return(
        [ john, jane, jim, joe, ],
        [ john, jim, joe, jane, ],
      )

      subject.generate_santas.should == [
        [ joe,  john ],
        [ john, jim  ],
        [ jane, joe  ],
        [ jim, jane  ],
      ]
    end
  end
end
