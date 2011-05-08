class ContactFormController < ApplicationController

  CONTACT_TEMPLATE = :contact_us

  def contact_form
      render_liquid_template_for(CONTACT_TEMPLATE, :status => "200 OK")
  end

  def contact_submit
    message = ContactMessage.new(params[:contact])
    if (message.valid?)
      ContactNotifier.deliver_contact_notification(message)
      render_liquid_template_for(CONTACT_TEMPLATE, 
        'message' => "Ihre Nachricht wurde gesendet. Vielen Dank! Ich melde mich baldmöglichst bei Ihnen.", :status => "200 OK")
    else
      render_liquid_template_for(CONTACT_TEMPLATE, 'errors' => message.errors.full_messages, 
        'submitted' => params[:contact], :status => "200 OK")
    end
  end
end
