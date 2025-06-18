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
        sh 'docker tag hello-js-app:latest srbhdockerhub1st/hello-js-app:latest'
      }
    }

    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push srbhdockerhub1st/hello-js-app:latest
          '''
        }
      }
    }
    
   stage('Deploy / Update Service') {
      steps {
          sh '''
              if docker service inspect hello-js-service > /dev/null 2>&1; then
                echo "Service exists. Updating..."
                docker service update --force --image srbhdockerhub1st/hello-js-app:latest hello-js-service
              else
                echo "Service not found. Creating..."
                docker service create --name hello-js-service --publish 8081:80 srbhdockerhub1st/hello-js-app:latest
              fi
        '''
      }
    }
  }
}
