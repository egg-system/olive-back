FROM ruby:2.6.3

ENV LANG C.UTF-8
ENV WORKSPACE=/usr/local/src

# install bundler. -v 1.16.6 は本番環境のバージョンに合わせている
RUN apt-get update && \
    apt-get install -y vim less && \
    apt-get install -y build-essential libpq-dev nodejs graphviz cron && \
    gem install bundler -v 1.16.6 && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

ENV DOCKERIZE_VERSION v0.6.1
RUN apt-get install -y wget \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

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

# server.pidのエラーをなくすための処理
COPY --chown=rails:rails ./start_up.sh /usr/local/start_up.sh
RUN chmod 744 /usr/local/start_up.sh

USER rails
WORKDIR $WORKSPACE

ADD --chown=rails:rails src $WORKSPACE
RUN bundle _1.16.6_ install

EXPOSE 3000
CMD ["/usr/local/start_up.sh"]
