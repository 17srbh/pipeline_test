pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git url: 'git@github.com:your-username/your-repo.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                echo 'Build steps go here'
                // e.g., sh './build.sh'
            }
        }
    }
}
