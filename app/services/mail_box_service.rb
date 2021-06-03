require "mailboxlayer"

class MailBoxService
  def initialize
    Apilayer::Mailbox.configure do |configs|
      configs.access_key = ENV['MAILBOX_ACCESS_KEY']
      configs.https = true
    end
  end

  def varify_email(email)
    sleep(1)
    Apilayer::Mailbox.check(email)
  end
end