FROM ruby:alpine
MAINTAINER Emmanuel Hadoux <emmanuel.hadoux@gmail.com>

WORKDIR /usr/local/app
RUN apk add --no-cache sqlite sqlite-libs
COPY Gemfile* ./
RUN apk add --no-cache sqlite-dev alpine-sdk \
    && bundle install \
    && apk del alpine-sdk sqlite-dev \
    && mkdir data
COPY . .

EXPOSE 9292
ENTRYPOINT ["rackup"]
