require 'spec_helper'

describe ComposeCommand do

  it_behaves_like "a command"

  before(:each) do
    @cmd = ComposeCommand.new
    @template = @cmd.instance_variable_get(:@template)
  end

  let(:config) { Configuration.instance }
  context "when first created" do
    its(:mail) { should_not be_nil }
    its("mail.from") { should eq Array(config.email_address) }

  end

  context "executing" do
    it "creates a temp file with the correct header" do
      header = @template.read
      header.should eq @cmd.send(:header)
    end
  end

  context "after the user fills in the template" do
    it "correctly populates the mail with user input" do

      subject_line = "trololo"
      to = "bob@foo.net"
      body = "hello, bob\n"
      template = "to: #{to}\nsubject: #{subject_line}\n#{body}"
      File.open(@template, "w") { |f| f.puts(template) }

      @cmd.send :fill_in_mail
      mail = @cmd.mail
      mail.subject.should eq subject_line
      mail.to[0].should eq to
      mail.body.to_s.should eq body
    end
  end

  after(:each) do
    @template.close
    @template.unlink
  end
end
