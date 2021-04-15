FROM ruby:2.6

RUN apt-get update

RUN apt-get install --assume-yes postgresql-client
RUN apt-get install --assume-yes ca-certificates
RUN apt-get install --assume-yes nodejs
RUN apt-get install --assume-yes graphviz

ENV APP /usr/src/app

RUN mkdir -p $APP

WORKDIR $APP

COPY Gemfile* $APP/

RUN bundle install --jobs=$(nproc)

COPY . $APP/

CMD ["bin/rails","server","-p","3000","-b","0.0.0.0"]