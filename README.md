# BBQ App
The application in which you can organize an event with your friends.

Deploy: https://bbqfriends.co.uk

Rails 7.0.2., Ruby 3.1.1.

run:
- `bundle`
- `rails db:migrate`
- `yarn install`
- `yarn build`
- `yarn build:css`
- `rails s`

### Implemented features:

- Authentication, Sessions (Devise)
- Authorization (Pundit)
- OAuth (Facebook, Github)
- 2 languages (ru, en), i18n
- Event: creating, editing, deleting
- Possibility to set a pin-code for private access
- Comments to the event
- Subscription to the event
- Sending email
- Uploading files and a gallery of event photos (carrierwave, lightbox)

Styles: Bootstrap 5.1.3

Tests: Rspec

Deployment: Capistrano
