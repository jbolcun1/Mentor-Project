require "net/http"

def send_mail(email, subject, body)
  response = Net::HTTP.post_form(URI("http://www.dcs.shef.ac.uk/cgi-intranet/public/FormMail.php"),
                                 "recipients" => email, "subject" => subject, "body" => body)
  response.is_a? Net::HTTPSuccess
end
