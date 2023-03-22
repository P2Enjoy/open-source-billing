class MailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.subject}"
    message.to = []
    message.cc = []
    message.bcc = []
  end
end