FROM ruby:2.4.3

RUN mkdir -p /var/www
RUN useradd --system --create-home --home /var/www/challenge-app --shell /bin/bash --user-group challenge-app

USER challenge-app:challenge-app
WORKDIR /var/www/challenge-app

COPY --chown=challenge-app:challenge-app Gemfile Gemfile.lock app.rb base.rb config config.ru /var/www/challenge-app/
COPY --chown=challenge-app:challenge-app config /var/www/challenge-app/config

ENV RAILS_ENV production
RUN bundle install --path vendor/bundle
# CMD ["bundle", "exec", "shotgun", "config.ru"]
CMD ["bundle", "exec", "shotgun", "-o0.0.0.0", "config.ru"]

EXPOSE 9393
