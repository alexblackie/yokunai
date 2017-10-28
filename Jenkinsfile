node {
  docker.image("ruby:2.4").inside {
    sh "bundle install"
    sh "bundle exec rspec"
  }
}
