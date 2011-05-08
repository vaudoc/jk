class ContactNotifier < ActionMailer::Base
  include Mephisto::Liquid::UrlMethods
  
  self.template_root = File.dirname(__FILE__) + '/views'
  
  def contact_notification(contact_message)
    recipients      "info@jankuhl.de"
    cc              contact_message.cc_email
    from            contact_message.author_email
    subject         "[jankuhl.de Anfrage] #{contact_message.name} #{contact_message.surname}: #{contact_message.subject}"
    body            "contact_message" => contact_message
  end
end

