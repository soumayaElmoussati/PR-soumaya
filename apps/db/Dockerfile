FROM postgres:11.1

# Install Ruby inside the Postgres image to run the Backup gem
RUN apt-get update -qq && apt-get install -y build-essential g++ libpq-dev ruby2.3 ruby-dev zlib1g-dev gcc libffi-dev make

RUN ruby -v

RUN gem install bundler

RUN bundle -v

RUN gem install backup

RUN gem install whenever

COPY schedule.rb /root/schedule.rb
