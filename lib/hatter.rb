require 'terminal'

terminal = Terminal.new
begin
  terminal.draw
  sleep(10)
ensure
  terminal.shutdown
end
