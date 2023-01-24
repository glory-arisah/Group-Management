# Group Management

* Ruby version - 3.0.0
* Rails version - 7.0.4

## Configuration
1. This application uses Postgresql as its Database Management System:
  * create a postgres role.
  * update database.yml file with the username and password of the new role created.
  * run `rails db:create`

## Running this project locally

From the repo

1. `git clone git@github.com:glory-arisah/Group-Management.git`
2. run `bundle install`
3. configure the app with postgres as stated under Configuration
4. run `rails db:migrate`
5. run `rspec` to confirm all tests passed
6. run `rails server` to start-up the application

* Deployment instructions
