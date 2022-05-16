require 'rest-client'

API_KEY = ENV['MAILGUN_API_KEY']
API_URL = "https://api:#{API_KEY}@api.mailgun.net/v2/<your-mailgun-domain>"

RestClient.post API_URL + "/messages",
                :from => "ev@example.com",
                :to => "ev@mailgun.net",
                :subject => "This is subject",
                :text => "Text body",
                :html => "<b>HTML</b> version of the body!"
