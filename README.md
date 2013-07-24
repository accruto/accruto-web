#Yoongfook basic-app for Rails.
#### Comes with a custom version of twitter bootstrap, and some static pages (home, about faq, contact)

1. Git clone this repo
2. git init
3. rails g rename:app_to <new-app-name>
4. Create staging and production environment on Heroku
5. Set environment variables in application.yml
6. Set database name in database.yml
7. rake figaro:heroku[app-name] to export env variables to Heroku
8. bundle install
9. rake db:migrate
10. Git commit and push to Github/Heroku
11. Create new Typekit font-kit