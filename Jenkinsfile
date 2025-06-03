pipeline {
  agent any

  stages {
    stage('Clone') {
      steps {
        git url: 'git@github.com:your-user/hello-js-app.git', branch: 'main'
      }
    }

    stage('Build') {
      steps {
        sh 'npm install'
        sh 'npm run build'
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
