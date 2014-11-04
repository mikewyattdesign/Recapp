# GROUP360 Events Application

## Dependencies

* Docker 1.3.0
    * boot2docker 1.3.0 if on OSX
* Fig 1.0.0

## Setup

1. Run `$ fig build` to build up the application image as declared in
   the Dockerfile.

## Development

* Run `$ fig up` to spin up the server for development.  The
  application should be available via http://<boot2docker ip>:3000/. To
  find out the IP of boot2docker's vm, run `$ boot2docker ip`.
* Run `$ fig run web bin/rspec` to run tests.
* If you change the Gemfile, update the Gemfile.lock and install the new
  gems with `$ fig run web bundle install`.
* In general, you can prefix commands with `$ fig run web`, and they
  will run in the application container.
