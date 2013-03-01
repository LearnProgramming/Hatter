require 'spec_helper'
require 'termbox'

describe View do

  let(:config) {Configuration.instance}

  subject(:view) { View.new({x0: 1, x1: 1, y0: 1, y1: 1}) }

  it "instantiates the correct mailbox by reading the config file" do
    maildir_format = config.maildir_format
    view.mailbox.class.name =~ /#{maildir_format}/
  end

  it "reads its color attribute from the config file" do
    fg = config.colors.foreground
    bg = config.colors.background
    view.colors[:fg].should eq Termbox::Colors[:green]
    view.colors[:bg].should eq Termbox::Colors[:black]
  end
end
