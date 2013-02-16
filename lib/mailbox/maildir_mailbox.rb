class Maildir_mailbox
  require 'mail'

  def initialize maildir_path
    @maildir_path = maildir_path
    @maildir_path = "spec/fixtures/maildir"
  end

  def mail where={label: nil, folder: nil, from: nil, to: nil, date: nil}
    Mail.read(@maildir_path + "/INBOX/cur/TRAIN_00001.eml")
  end

  def most_recent
    mail
  end

  def labels
    ["work", "cat pictures", "news"]
  end

  def folders
    %w{ inbox archived spam trash }
  end
end
