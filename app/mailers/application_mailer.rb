class ApplicationMailer < ActionMailer::Base
  default from: 'devs4good@gmail.com'
  layout 'mailer'

  def default_url_options
    if Rails.env.development?
      {:host => "localhost:3000"}
    else
      {}
    end
  end
end
