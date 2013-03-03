require 'spec_helper'

describe QuitCommand do

  it "sends :shutdown to the Terminal" do
    terminal = double("terminal")
    terminal.stub(:shutdown) { true }
    terminal.should_receive(:shutdown)
    cmd = QuitCommand.new terminal
    cmd.execute
  end

end
