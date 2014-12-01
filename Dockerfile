FROM ruby:2.1.4

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update

# We need libav-tools to run Paperclip-ffmpeg
RUN apt-get install -y nodejs libav-tools \
    --no-install-recommends \
    --fix-missing
RUN rm -rf /var/lib/apt/lists/*

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN bundle install

COPY . /usr/src/app
