pipeline {
  agent any

  stages {
    stage('Clone') {
      steps {
         withCredentials([sshUserPrivateKey(credentialsId: 'github-ssh-key', keyFileVariable: 'SSH_KEY')]) {
          sh '''
            mkdir -p ~/.ssh
            cp $SSH_KEY ~/.ssh/id_rsa
            chmod 600 ~/.ssh/id_rsa
            ssh-keyscan github.com >> ~/.ssh/known_hosts
            git clone git@github.com:17srbh/pipeline_test.git
          '''
       } 
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
