require 'termbox'
require 'views/mail_view'
require 'views/label_view'
require 'views/folder_view'

module Termbox
  TB_INPUT_ESCAPE = 1
  TB_INPUT_ALT = 2
end

class Terminal

  def initialize
    initialize_termbox
    initialize_views
  end

  def draw
    Termbox.tb_clear
    @views.each {|view| view.draw}
    Termbox.tb_present
  end

  def shutdown
    Termbox.tb_shutdown
    exit
  end

  def get_user_input
    Termbox.tb_poll_event(@event)
    ascii_to_symbol @event[:ch]
  end


  private

  def initialize_views
    folder_view_location = {x0: 0, y0: 0, x1: 19, y1: 40}
    label_view_location = {x0: 0, y0: 41, x1: 19, y1: 79}
    mail_view_location = {x0: 20, y0: 0, x1: 79, y1: 79}
    @views = [MailView.new(mail_view_location),
              LabelView.new(label_view_location),
              FolderView.new(folder_view_location)]
  end

  def ascii_to_symbol(i)
    i.chr.intern
  end

  def initialize_termbox
    libtermbox_path = Configuration.instance.termbox_library_path
    Termbox.initialize_library libtermbox_path
    unless Termbox.tb_init
      raise "Failed failed to start UI"
    end
    @event = Termbox::Event.new
    Termbox.tb_select_input_mode Termbox::TB_INPUT_ESCAPE
  end

end
