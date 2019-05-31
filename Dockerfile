FROM ruby:2.6.3

ENV LANG C.UTF-8
ENV WORKSPACE=/usr/local/src

# install bundler. -v 2.0.1 はエラーが発生するため、1.17.3をinstall
RUN apt-get update && \
    apt-get install -y vim less && \
    apt-get install -y build-essential libpq-dev nodejs graphviz cron && \
    gem install bundler -v 1.17.3 && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

# node update
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

# create user and group.
RUN groupadd -r --gid 1000 rails && \
    useradd -m -r --uid 1000 --gid 1000 rails

# create directory.
RUN mkdir -p $WORKSPACE $BUNDLE_APP_CONFIG && \
    chown -R rails:rails $WORKSPACE && \
    chown -R rails:rails $BUNDLE_APP_CONFIG

USER rails
WORKDIR $WORKSPACE

# install ruby on rails.
ADD --chown=rails:rails src $WORKSPACE
RUN bundle install

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]