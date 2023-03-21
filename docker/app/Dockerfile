FROM ruby:2.7.1-slim-buster

#RUN sudo apt update; \
#    sudo apt install gnupg2; \
#    gpg2 --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB ; \
#    \curl -sSL https://get.rvm.io -o rvm.sh
#
#RUN cat rvm.sh | bash -s stable --rails
#RUN source ~/.rvm/scripts/rvm; \
#    rvm pkg install openssl; \
#    rvm install 2.7.1 --with-openssl-dir=$HOME/.rvm/usr; \
#    rvm gemset create osb;
#

RUN apt-get update; \
    apt-get -y install curl;

RUN curl -sSL https://deb.nodesource.com/setup_16.x -o nodejs.sh; \
    cat nodejs.sh | bash -; \
    npm install -g yarn;

RUN apt-get update; \
    apt-get -y install nodejs; \
    apt-get -y install libicu-dev imagemagick libmagick++-dev wkhtmltopdf;

RUN apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/osb
WORKDIR /usr/src/osb

RUN git clone https://github.com/P2Enjoy/open-source-billing.git /usr/src/osb

# rvm pkg install openssl; rvm install 2.7.1 --with-openssl-dir=$HOME/.rvm/usr
# nvm use 16
# npm install -g yarn
# yarn install
# rails webpacker:compile
# rails generate delayed_job:active_record
# rails db:migrate
# rails server

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
