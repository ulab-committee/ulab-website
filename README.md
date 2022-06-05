# ULAB Website

This README documents the steps necessary to get the website up and running.

* The website is a Rails app running on Ruby 2.7.6 (check `.ruby-version` to confirm)

* Dependencies not installed by Bundler include:

  * PostgreSQL, which allows the app to manipulate PostgreSQL databases
    
    * On Mac, just download [`Postgres.app`](https://postgresapp.com)
        
    * On Windows and Linux, follow the [instructions on the PostgreSQL website](https://www.postgresql.org/download/)
  
  * Redis, for caching and job queues

    * On Mac, you can download [Redis Server](https://langui.net/redis-server/) from the App Store
    
    * On Windows and Linux, follow the [instructions on the Redis website](https://redis.io/download)

* Configuration

  * Create the databases for development and testing by running `bin/rails db:create`, repeat in production to create the
    production database

  * You can seed the database with sample data by running `bin/rails db:seed`—find the data used in `db/seeds.rb`

  * To run the test suite, run `bin/rails test`

  * In production, the app deploys a set of Docker containers using [Docker Compose](https://docs.docker.com/compose/)

* The website makes use of a variety of services when running

  * The app is deployed to a [DigitalOcean](digitalocean.com/) droplet

  * [Amazon S3](https://aws.amazon.com/s3) is used for cloud storage of images and documents

* CI (Contiguous Integration) services include:

  * [GitHub Actions](https://github.com/features/actions) for running test suites automatically

  * [Code Climate](https://codeclimate.com/quality/), which runs checks on code and monitors test coverage

* Services which allow the identification of problems with the live website include:

  * [Skylight](https://www.skylight.io), which monitors requests and responses for slowness and other issues

  * [Depfu](https://depfu.com), which checks for updated versions of dependencies

  * [Bugsnag](https://www.bugsnag.com), which logs errors which the app reports and creates corresponding issues in this repo

  * [Scout](https://scoutapm.com), which monitors resource usage

* The app deploys to a DigitalOcean droplet using Git hooks

  * Before any PR is merged, all GitHub actions must succeed

  * To deploy the app, push to `deploy@ssh.ulab.org.uk:ulab-website-production`. The server then runs `docker-compose up --build`, which rebuilds and deploys the Docker containers.

