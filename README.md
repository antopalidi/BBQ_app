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

run:
- `bundle`

###### Setup your API keys:

- Add file `config/database.yml`:
```
default: &default
  adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  <<: *default
  database: db/development.sqlite3

test:
  <<: *default
  database: db/test.sqlite3

production:
  <<: *default
  adapter: postgresql
  host: localhost
  port: 5432
  database: <database_name>
  user: <user_name>
  password: <user_password>
```

- Add file `.env` to the root of the project:

```
MAILJET_API_KEY=
MAILJET_SECRET_KEY=
MAILJET_SENDER=

GOOGLE_MAPS_API_KEY=

S3_ACCESS_KEY=
S3_BUCKET_NAME=
S3_BUCKET_REGION=
S3_SECRET_KEY=

SECRET_KEY_BASE=

FACEBOOK_APP_ID=
FACEBOOK_APP_SECRET=

GITHUB_KEY=
GITHUB_SECRET=
```

run:
- `rails db:migrate`
- `yarn install`
- `yarn build`
- `yarn build:css`
- `rails s`
