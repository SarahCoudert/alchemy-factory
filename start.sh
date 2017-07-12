PORT=7000
bundle install && bundle exec rake assets:precompile db:migrate && bundle exec thin start -p $PORT -d
echo "Thin start with port $PORT"
