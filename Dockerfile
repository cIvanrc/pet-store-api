# 1: Use ruby 2.7.2 as base:
FROM ruby:2.7.2-alpine AS runtime

#RUN adduser -S $USER 
RUN addgroup -g 1000 -S username && \
    adduser -u 1000 -S username -G username

# 2: We'll set the application path as the working directory
RUN mkdir /app
WORKDIR /app


# 6: Install the development & runtime packages:
RUN set -ex && apk add --no-cache \
  build-base \
  ca-certificates \
  libpq \
  openssl \
  less \
  postgresql-dev \
  tzdata \
  libxslt-dev libxml2-dev libxml2-dev curl-dev

RUN apk add --update bash && rm -rf /var/cache/apk/*

# 8: Copy the project's Gemfile + lock:
ADD Gemfile* /app/

# 9: Install the current project gems - they can be safely changed later during
# development via `bundle install` or `bundle update`:
RUN set -ex && bundle install --jobs=4 --retry=3

ADD . /app
