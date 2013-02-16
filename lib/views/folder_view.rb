class Folder_view < View

  def initialize location
    super
  end

  def draw
    draw_folders
    draw_horizontal_line @end_y
  end

  private

  def draw_folders
    x = @start_x
    y = @start_y
    y = draw_text("Folders:", x, y)
    @mailbox.folders.each do |folder|
      y = draw_text folder, x, y + 1
    end
  end
end
