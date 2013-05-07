require 'spec_helper'
require 'relative'
require 'configtoolkit/keyvaluereader'

describe Configuration do
  let(:maildir_path) { '/path/to/maildir' }
  let(:maildir_format) { 'maildir' }
  let(:termbox_library_path) { '/usr/lib/libtermbox.so' }

  subject(:config) { Configuration.instance }

  context 'with a user config file should override defaults' do
      let(:user_file_exists) { File.exists?(File.join(Dir.home, '.hatterrc')) }

      its(:maildir)        { should_not eq maildir_path   if user_file_exists }
      its(:maildir_format) { should_not eq maildir_format if user_file_exists }
  end

  context 'with an invalid config file' do
    let(:config_file) { File.read(Configuration::CONFIG_FILE) }

    it 'barfs when required values are missing' do
      config_file.gsub!(/maildir/, 'asdf')
      File.open('invalid_config', 'w') { |file| file.write config_file }
      expect { Configuration.send(:new, 'invalid_config') }.to raise_error
      FileUtils::rm('invalid_config')
    end
  end

  context 'with a valid config file' do
    subject(:config) { Configuration.send(:new, Configuration::CONFIG_FILE) }

    its(:maildir)        { should eq maildir_path }
    its(:maildir_format) { should eq maildir_format }

    its(:termbox_library_path) { should eq termbox_library_path }

    describe 'colors settings' do
      subject { config.colors }
      
      its(:foreground) { should eq 'green' }
      its(:background) { should eq 'black' }
    end

    describe 'nested config keys' do
      subject { config.keys }

      its(:c) { should eq 'compose' }
      its(:q) { should eq 'quit' }
    end
  end
end
