require 'spec_helper'

describe SolitaireCipher::Encrypter do
  describe '.encrypt' do
    it 'it should encrypt the message' do
      SolitaireCipher::Encrypter.encrypt('Code in Ruby, live longer!').should == 'GLNCQ MJAFF FVOMB JIYCB'
    end
  end
end
