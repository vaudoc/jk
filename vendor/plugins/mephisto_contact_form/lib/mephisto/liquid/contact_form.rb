module Mephisto
  module Liquid
    class ContactForm < ::Liquid::Block

      def render(context)
        result = []
	
        context.stack do

          if context['message'].blank? 
            errors = context['errors'].blank? ? '' : %Q{<ul id="contact-errors"><li>#{context['errors'].join('</li><li>')}</li></ul>}

            submitted = context['submitted'] || {}
            submitted.each{ |k, v| submitted[k] = CGI::escapeHTML(v) }
            
            context['form'] = {
              'mrs'     => %(<select id="contact_mrs" name="contact[mrs]" value="#{submitted['mrs']}"> 
                          <option value="Frau" selected="selected">Frau</option> 
                          <option value="Herr">Herr</option> 
                          <option value="Firma">Firma</option> 
                          </select>),
              'name'    => %(<input type="text" id="contact_name" name="contact[name]" value="#{submitted['name']}" />),
              'surname' => %(<input type="text" id="contact_surname" name="contact[surname]" value="#{submitted['surname']}" />),
              'company' => %(<input type="text" id="contact_company" name="contact[company]" value="#{submitted['company']}" />),
              'street'  => %(<input type="text" id="contact_street" name="contact[street]" value="#{submitted['street']}" />),
              'city'    => %(<input type="text" id="contact_city" name="contact[city]" value="#{submitted['city']}" />),
              'phone'   => %(<input type="text" id="contact_author_phone" name="contact[author_phone]" value="#{submitted['author_phone']}" />),
              'fax'     => %(<input type="text" id="contact_author_fax" name="contact[author_fax]" value="#{submitted['author_fax']}" />),
              'email'   => %(<input type="text" id="contact_author_email" name="contact[author_email]" value="#{submitted['author_email']}" />),
              'cc'      => %(<input type="text" id="contact_cc_email" name="contact[cc_email]" value="#{submitted['cc_email']}" />),
              'subject' => %(<input type="text" id="contact_subject" name="contact[subject]" value="#{submitted['subject']}" />),
              'body'    => %(<textarea id="contact_body" name="contact[body]" rows=10>#{submitted['body']}</textarea>),
              'submit'  => %(<input type="submit" value="Send" />)
            }

            result << %(<form id="contact-form" method="post" action="/contact_submit">#{[errors]+render_all(@nodelist, context)}</form>)
          else
            result << %(<p id="contact-message">#{context['message']}</p>)
          end
        end
        result
      end
    end
  end
end
