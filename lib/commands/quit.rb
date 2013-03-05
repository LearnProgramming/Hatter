require 'terminal'

class QuitCommand

  def initialize terminal
    @terminal = terminal
  end

  def execute
    @terminal.shutdown
  end

  def unexecute
  end
end
