FROM ruby:2.4.6-alpine3.10

WORKDIR /rails

COPY Gemfile Gemfile.lock ./

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash git \
    # Rails
    tzdata nodejs\
    # nokogiri
    build-base libxml2-dev libxslt-dev \
    # sqlite
    sqlite-dev \
    && bundle install
