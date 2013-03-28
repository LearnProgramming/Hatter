require 'rspec'
require 'rspec/mocks'
require 'rspec-spies'

ENV["HEADLESS"] = "ya, don't GUI for testing."

require './lib/hatter'
require './lib/configuration'
require './lib/views/view'
require './lib/command_factory'
require './lib/commands/quit'
require './lib/commands/compose'
require './spec/commands/shared_examples_for_commands'
