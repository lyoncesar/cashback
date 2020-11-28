FROM ruby:2.7.0
ENV LC_ALL C.UTF-8
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  tzdata
RUN apt-get install --no-install-recommends yarn \
  && rm -rf /var/lib/apt/lists/*
WORKDIR "/app"
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --jobs=$(nproc)
