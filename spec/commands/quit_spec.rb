require 'spec_helper'

describe QuitCommand do


  let(:terminal) { double('terminal', shutdown: true ) }
  let(:command) { QuitCommand.new terminal }

  subject{ command }
  it_behaves_like "a command"

  context "After executing" do
    context "the terminal" do
      before { command.execute }
      subject { terminal }

      it { should have_received :shutdown }
    end
  end
end
