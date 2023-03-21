class MailInterceptor
  def self.delivering_email(message)
    message.subject = "OpenSourceBilling: #{message.subject}"
    message.to = []
    message.cc = []
    message.bcc = []
  end
end