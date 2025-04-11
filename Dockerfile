FROM ruby:3.2.2

# Node.jsとyarnのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client yarn

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install