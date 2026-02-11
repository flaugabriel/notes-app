FROM ruby:3.3

WORKDIR /app

# Dependências básicas
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

# 🔥 Garante Bundler compatível com Rails 8
RUN gem update --system && gem install bundler

COPY Gemfile Gemfile.lock ./

# 🔥 Evita problemas de plataforma
RUN bundle config set force_ruby_platform true

RUN bundle install

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]
