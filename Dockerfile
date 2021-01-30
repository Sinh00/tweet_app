FROM ruby:2.6.1

RUN apt-get update && \
    apt-get install -y mysql-client nodejs vim --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /tweet_app

WORKDIR /tweet_app

ADD ./Gemfile /tweet_app/Gemfile
ADD ./Gemfile.lock /tweet_app/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /tweet_app