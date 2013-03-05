require 'spec_helper'

describe CommandFactory do

  subject(:factory) { CommandFactory.new nil }
  let(:command) { factory.command(:foo) }

  context "Creates commands which:" do
    subject { command }
    it_behaves_like "a command"
  end

  let(:key) { :q }

  context "Instantiates the commands matching the user's input." do
    context "The returned command" do
      subject { factory.command(key) }
      it { should be_a(QuitCommand) }
    end
  end
end
