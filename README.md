#Accruto Web App (accruto.com)

1. Git clone this repo
2. git init
3. Create staging and production environment on Heroku
4. Set environment variables in application.yml
5. Set database name in database.yml
6. rake figaro:heroku[app-name] to export env variables to Heroku
7. bundle install
8. rake db:migrate
9. Git commit and push to Github/Heroku
10. Create new Typekit font-kit