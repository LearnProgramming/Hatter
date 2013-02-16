class Label_view < View

  def initialize location
    super
  end

  def draw
    draw_labels
  end

  private

  def draw_labels
    x = @start_x
    y = @start_y
    y = draw_text("Labels:", x, y)
    @mailbox.labels.each do |label|
      y = draw_text label, x, y + 1
    end
  end
end
