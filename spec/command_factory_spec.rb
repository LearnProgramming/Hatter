require 'spec_helper'

describe CommandFactory do

  subject { CommandFactory.new nil}

  it "Creates instances of type Command" do
    subject.command(:foo).should be_a(Command)
  end

  it "Creates instances of command matching the key the user pressed." do
    key = :q
    subject.command(key).should be_a(QuitCommand)
  end
end
