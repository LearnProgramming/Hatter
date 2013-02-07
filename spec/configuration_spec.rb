require 'spec_helper'
require 'relative'
require 'configtoolkit/keyvaluereader'

describe 'Configuration' do

  before :all do
    @maildir_path = "/path/to/maildir"
    CONFIG_FILE = File.expand_path_relative_to_caller("../.hatterrc")
    @maildir_format = "maildir"
    @config = Configuration.new() do |config|
      config.maildir = @maildir_path
      config.maildir_format = @maildir_format
    end
  end

  it "contains all the required configuration settings" do
    @config.maildir?.should be_true
    @config.maildir_format?.should be_true
  end

  it "the settings have the correct values" do
    @config.maildir.should eq @maildir_path
    @config.maildir_format.should eq @maildir_format
  end

  it "reads the configuration values from file" do
    config = Configuration.from_file CONFIG_FILE
    config.maildir.should eq @maildir_path
    config.maildir_format.should eq @maildir_format
  end

  it "barfs when required values are missing" do
    config = File.read CONFIG_FILE
    config.gsub!(/maildir/, 'asdf')
    File.open("invalid_config", "w") {|file| file.write config}
    expect {Configuration.from_file("invalid_config")}.to raise_error
    FileUtils::rm("invalid_config")
  end
end
