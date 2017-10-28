pipeline {
  agent { dockerfile true }
  options {
    authorizationMatrix(["hudson.model.Item.Read:anonymous"])
  }

  stages {
    stage("Test") {
      steps {
        sh "bundle install"
        sh "bundle exec rspec"
      }
    }
  }
}
