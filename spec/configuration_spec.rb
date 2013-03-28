require 'spec_helper'
require 'relative'
require 'configtoolkit/keyvaluereader'

describe 'Configuration' do

  before :all do
    CONFIG_FILE = File.expand_path_relative_to_caller("../hatterrc")
    @maildir_path = "/path/to/maildir"
    @maildir_format = "maildir"
    @termbox_library_path = "/usr/lib/libtermbox.so"
  end

  it "barfs when required values are missing" do
    config = File.read CONFIG_FILE
    config.gsub!(/maildir/, 'asdf')
    File.open("invalid_config", "w") {|file| file.write config}
    expect {Configuration.instance "invalid_config"}.to raise_error
    FileUtils::rm("invalid_config")
  end

  it "reads the configuration values from file" do
    config = Configuration.instance
    config.maildir.should eq @maildir_path
    config.maildir_format.should eq @maildir_format
  end

  it "the settings have the correct values" do
    config = Configuration.instance
    config.maildir.should eq @maildir_path
    config.maildir_format.should eq @maildir_format
    config.termbox_library_path.should eq @termbox_library_path
  end

  it "contains a nested config with colors" do
    config = Configuration.instance
    config.colors.foreground.should eq "green"
    config.colors.foreground.should eq "green"
  end

  it "contains a nested config with keys" do
    config = Configuration.instance
    config.keys.c.should eq "compose"
    config.keys.q.should eq "quit"
  end
end
