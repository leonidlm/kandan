FROM ruby:1.9.3

RUN apt-get update -qq && \
    apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime
RUN apt-get install -y nodejs

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# ADD Gemfile* $APP_HOME/
# To speed up gems installation, run `bundle package --all` locally and then
# uncommend the following line:
ADD . $APP_HOME
RUN bundle install --retry 3 --jobs 3

#ADD . $APP_HOME

RUN bundle exec rake assets:precompile && \
    rm -rf /app/tmp/pids/server.pid

