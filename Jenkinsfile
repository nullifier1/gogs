pipeline {
  agent { dockerfile true }
  stages {
    stage('Test') {
      steps {
        sh '''
          su
          echo "go test ./..."
        '''
      }
    }
    stage('build') {
      steps {
        sh '''
          export CGO_ENABLED=0
          echo "go build -o gogs"
          echo $USER
        '''
      }
    }
    stage('Build Image') {
            steps {
                sh 'docker build -t infinityofcore/testgogs .'
            }
        }
        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_HUB_PWD', usernameVariable: 'DOCKER_HUB_USER')]) {
                    sh "sudo docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PWD"
                    sh 'sudo docker push infinityofcore/testgogs'
                }
            }
        }
    }
}
