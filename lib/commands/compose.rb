require 'mail'

class ComposeCommand

  attr_reader :mail

  def initialize
    create_mail_template
    create_mail
  end

  # Starts $EDITOR to get the mail body, subject and recipient.  Then
  # sends the mail.
  def execute
    fill_in_mail_template
    fill_in_mail
    send_mail
    delete_template
  end

  def unexecute
  end

  private

  def create_mail_template
    @template = Tempfile.new('mail')
    add_header
  end

  def create_mail
    @mail = Mail.new

    config = Configuration.instance
    method = config.mail_delivery_method.to_sym
    from = config.email_address

    @mail.delivery_method method
    @mail.from = from
  end

  def fill_in_mail_template
    editor = ENV['EDITOR']
    throw "$EDITOR isn't set!" unless editor

    command = "#{editor} #{@template.to_path}"
    success = system(command)
    throw "Failed to run #{command}" unless success
  end

  def fill_in_mail
    @mail.to = get_recipient
    @mail.subject = get_subject
    @mail.body = get_body
  end

  def add_header
    File.open(@template, 'w') { |f| f.write header }
  end

  def header
    "to: \nsubject: \n"
  end

  def get_recipient
    @template.rewind
    @template.readlines[0].strip.chomp[4..-1]
  end

  def get_subject
    @template.rewind
    @template.readlines[1].strip.chomp[9..-1]
  end

  def get_body
    @template.rewind
    lines = @template.readlines[2..-1]
    lines.join.lstrip
  end

  def delete_template
    @template.close
    @template.unlink
    @template = nil
  end

  def send_mail
    @mail.deliver
    @mail = nil
  end

end
