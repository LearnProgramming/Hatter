require 'configuration'
require 'termbox'

class View

  attr_reader :colors, :mailbox

  def initialize(location)
    @Border_width = 1
    @start_x = location[:x0]
    @start_y = location[:y0]
    @end_x = location[:x1]
    @end_y = location[:y1]
    set_mailbox
    set_colors
  end

  def draw_text(text, x, y)
    words = text.split(/\s+/)
    words.each do |word|
      if x + word.length + 1 >= @end_x
        y += 1
        x = @start_x + @Border_width + 1
        redo
      elsif y >= @end_y
        return y
      end
      word.each_char do |c|
        Termbox.tb_change_cell(x, y, c.ord, @colors[:bg], @colors[:fg])
        x += 1
      end
      Termbox.tb_change_cell(x, y, " ".ord, @colors[:bg], @colors[:fg])
      x += 1
    end
    return y
  end

  def draw_horizontal_line(at)
    @start_x.upto(@end_x) do |x|
      Termbox.tb_change_cell(x, at, " ".ord, @colors[:bg], @colors[:fg])
    end
  end

  def draw_vertical_line(at)
    @start_y.upto(@end_y) do |y|
      Termbox.tb_change_cell(at, y, " ".ord, @colors[:bg], @colors[:fg])
    end
  end

  private

  # Reads the maildir format from config file.  Requires the class and sets
  # @mailbox to mailbox/<maildir-format>Mailbox
  def set_mailbox
    config = Configuration.instance
    maildir_format = config.maildir_format
    mailbox_class = maildir_format.capitalize + "Mailbox"
    class_dir = File.expand_path('../../', __FILE__) + "/mailbox"
    mailbox_file = File.join class_dir, maildir_format + "_mailbox"
    require mailbox_file
    maildir_path = config.maildir
    @mailbox = self.class.const_get(mailbox_class).new maildir_path
  end

  def set_colors
    colors = Configuration.instance.colors
    prefix = 'Termbox::Colors[:'
    suffix = ']'
    fg = prefix + colors.foreground + suffix
    bg = prefix + colors.background + suffix
    @colors = {fg: (eval fg), bg: (eval bg)}
  end

end
