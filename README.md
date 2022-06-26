# BBQ App

![RubyOnRails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)

The application in which you can organize an event with your friends.

Deploy: https://bbqfriends.co.uk

Rails 7.0.2., Ruby 3.1.1.

### Implemented features:

- Authentication, Sessions (Devise)
- Authorization (Pundit)
- OAuth (Facebook, Github)
- 2 languages (ru, en), i18n
- Event: creating, editing, deleting
- Google Maps
- Possibility to set a pin-code for private access
- Comments to the event
- Subscription to the event
- Sending email
- Uploading files and a gallery of event photos (carrierwave, lightbox)

Styles: Bootstrap 5.1.3

Tests: Rspec

Deployment: Capistrano

#### Usage:

- Clone repo:

```
git clone https://github.com/antopalidi/BBQ_app
```
- Go to the app folder

###### Setup your API keys and database:

`.env`,
`config/database.yml`

Run file `bin/setup` 
