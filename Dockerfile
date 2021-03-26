FROM ruby:3.0.0

WORKDIR /BookManager-server

COPY Gemfile* /BookManager-server/

RUN bundle install
