pipeline {
  agent {
    docker { image 'infinityofcore/test' }
  }
  stages {
    stage('Test') {
      steps {
        sh '''
          go test ./...
        '''
      }
    }
    stage('build') {
      steps {
        sh '''
          export CGO_ENABLED=0
          go build -o gogs
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
                    sh "docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PWD"
                    sh 'docker push infinityofcore/testgogs'
                }
            }
        }
    }
}
