pipeline {
  agent any

  stages {
    stage('Clone') {
      steps {
        git url: 'git@github.com:17srbh/pipeline_test.git', branch: 'main'
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t hello-js-app .'
      }
    }

    stage('Deploy to Swarm') {
      steps {
        sh 'docker stack deploy -c docker-compose.yml hello-stack'
      }
    }
  }
}
