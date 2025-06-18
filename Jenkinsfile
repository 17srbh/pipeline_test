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
            rm -rf pipeline_test
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

   stage('Deploy / Update Service') {
      steps {
        sh '''
          docker service inspect hello-js-service >/dev/null 2>&1
          if [ $? -eq 0 ]; then
            docker service update --force --image hello-js-app:latest hello-js-service
          else
            docker service create --name hello-js-service \
              --publish 8081:80 \
              hello-js-app:latest
          fi
        '''
      }
    }
  }
}
