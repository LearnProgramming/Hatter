shared_examples "a command" do

  it { should respond_to :execute }
  it { should respond_to :unexecute }

end
