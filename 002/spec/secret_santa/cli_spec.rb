require 'spec_helper'

describe SecretSanta::CLI do
  describe '#run' do
    let(:mock_generator) do
      mock(:generator).tap do |m|
        m.stub(:generate_santas).and_return([[:a, :b], [:c, :d]])
      end
    end

    let(:mock_mailer) { mock(:mailer).tap { |m| m.stub(:deliver) } }

    before(:each) do
      STDIN.stub(:readlines).and_return([
        'Bruce Wayne      <bruce@imbatman.com>',
        'Virgil Brigman   <virgil@rigworkersunion.org>',
        'Lindsey Brigman  <lindsey@iseealiens.net>'
      ])

      SecretSanta::InputParser.stub(:parse)
      SecretSanta::Generator.stub(:new).and_return(mock_generator)
      SecretSanta::Mailer.stub(:santa_msg).and_return(mock_mailer)
    end

    it 'should read all the lines from standard input' do
      STDIN.should_receive(:readlines)

      subject.run
    end

    it 'should parse all the lines into people' do
      SecretSanta::InputParser.should_receive(:parse).with('Bruce Wayne      <bruce@imbatman.com>')
      SecretSanta::InputParser.should_receive(:parse).with('Virgil Brigman   <virgil@rigworkersunion.org>')
      SecretSanta::InputParser.should_receive(:parse).with('Lindsey Brigman  <lindsey@iseealiens.net>')

      subject.run
    end

    it 'should generate the secret santas for the given people' do
      mock_generator.should_receive(:generate_santas)

      subject.run
    end

    it 'should send out emails to all the santas' do
      SecretSanta::Mailer.should_receive(:santa_msg).with(:a, :b).and_return(mock_mailer)
      SecretSanta::Mailer.should_receive(:santa_msg).with(:c, :d).and_return(mock_mailer)

      subject.run
    end
  end
end
