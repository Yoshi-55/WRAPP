FROM ruby:3.3.6 as base

ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

RUN apt-get update -qq \
&& apt-get install -y ca-certificates curl gnupg wget \
&& mkdir -p /etc/apt/keyrings \
&& curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
&& NODE_MAJOR=20 \
&& echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
&& curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /etc/apt/keyrings/yarn.gpg \
&& echo "deb [signed-by=/etc/apt/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    tzdata \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir /myapp
WORKDIR /myapp

RUN gem install bundler

# ========================================
# Development
# ========================================
FROM base as development

RUN apt-get update -qq && apt-get install -y vim \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

COPY . /myapp

EXPOSE 3000

# ========================================
# Production
# ========================================
FROM base as production

ENV RAILS_ENV=production \
    BUNDLE_WITHOUT="development:test" \
    NODE_ENV=production

COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' \
&& bundle install --jobs 4 --retry 3

COPY package.json yarn.lock* ./
RUN yarn install --production --frozen-lockfile

COPY . /myapp

# NOTE: SECRET_KEY_BASE はビルド時のダミー値。本番環境では ENV で実際の値を渡すこと
RUN mkdir -p tmp/pids tmp/sockets log \
&& SECRET_KEY_BASE=dummy bundle exec rails assets:precompile

RUN useradd -m -u 1000 rails \
&& chown -R rails:rails /myapp

USER rails

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
