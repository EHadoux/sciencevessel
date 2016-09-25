FROM ruby:alpine
MAINTAINER Emmanuel Hadoux <emmanuel.hadoux@gmail.com>

RUN apk add --no-cache sqlite
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install
RUN sequel -m migrations sqlite://data/sciencevessel.db

EXPOSE 9292
ENTRYPOINT ["rackup"]

