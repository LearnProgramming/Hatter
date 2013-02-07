require 'configtoolkit'
require 'configtoolkit/keyvaluereader'

class Configuration < ConfigToolkit::BaseConfig

  # Reads a configuration from file.
  #
  # @param [String] configPath the path to a configuration file.
  #
  # @return [Configuration] with values loaded from file.
  def self.from_file configPath
    reader = ConfigToolkit::KeyValueReader.new configPath
    load reader
  end

  add_required_param(:maildir, String)
  add_required_param(:maildir_format, String)
end
