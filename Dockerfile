FROM ruby:2.6.1

RUN apt-get update && \
    apt-get install -y mysql-client nodejs vim --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn
# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
apt-get install nodejs

RUN mkdir /tweet_app

WORKDIR /tweet_app

ADD ./Gemfile /tweet_app/Gemfile
ADD ./Gemfile.lock /tweet_app/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /tweet_app