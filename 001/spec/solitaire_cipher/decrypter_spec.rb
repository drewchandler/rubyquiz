require 'spec_helper'

describe SolitaireCipher::Decrypter do
  describe '.decrypt' do
    it 'it should decrypt the message' do
      SolitaireCipher::Decrypter.decrypt('GLNCQ MJAFF FVOMB JIYCB').should == 'CODEI NRUBY LIVEL ONGER'
    end
  end
end
