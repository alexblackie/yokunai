pipeline {
  agent { dockerfile true }

  stages {
    stage("Test") {
      steps {
        sh "bundle install"
        sh "bundle exec rspec"
      }
    }
  }
}
