FROM ruby:3.2.2

# Node.jsとYarnのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update -qq && \
    apt-get install -y nodejs postgresql-client && \
    npm install -g yarn

WORKDIR /app
COPY . /app/

# 依存関係のインストール
RUN bundle install
RUN yarn install

CMD ["rails", "server", "-b", "0.0.0.0"]