class CommandFactory

  def initialize(terminal)
    @terminal = terminal
    require_commands
  end

  # Instantiates the command object corresponding to `key`.
  # @param key [Symbol] the key the user pressed on the keyboard.
  # @return [Command] the command the user wishes to execute.
  def command(key)
    name = command_name key
    create_command name
  end

  private

  def require_commands
    commands = File.join(File.dirname(__FILE__), "commands")  + "/*"
    Dir[commands].each { |file| eval "require '#{file}'" }
  end

  def create_command name
    case name
    when /QuitCommand/
      QuitCommand.new(@terminal)
    when /ComposeCommand/
      ComposeCommand.new
    else
      NoOpCommand.new
    end
  end

  def command_name(key)
    begin
      keys = "Configuration.instance.keys"
      cmd = eval "#{keys}.#{key.to_s}"
    rescue SyntaxError
      "NoOp"
    end
    cmd.capitalize + "Command"
  end

end
