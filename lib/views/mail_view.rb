require 'views/view'
require 'termbox'

class MailView < View

  def initialize(location)
    super
    @mail = @mailbox.most_recent
  end

  def draw
    draw_borders
    draw_mail
  end

  private

  def draw_borders
    draw_horizontal_line @start_y
    draw_horizontal_line @end_y
    draw_vertical_line @start_x
    draw_vertical_line @end_x
  end

  def draw_mail
    from, = @mail.from
    subject = @mail.subject
    text = @mail.body.decoded
    x = @start_x + @Border_width + 1
    y = @start_y + @Border_width + 1

    y = draw_text(("From: " + from), x, y) + 1
    y = draw_text(("Subject: " + subject), x, y + 1) + 1
    draw_text text, x, y + 1
  end

end
