require 'commands/command'
require 'terminal'

class QuitCommand < Command

  def initialize terminal
    @terminal = terminal
  end

  def execute
    @terminal.shutdown
  end

end
