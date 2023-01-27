pipeline {
  agent none
  stages {
    stage('Test') {
      agent { dockerfile true}
      steps {
        sh '''
          echo "go test ./..."
        '''
      }
    }
    stage('build') {
      agent { dockerfile true}
      steps {
        sh '''
          export CGO_ENABLED=0
          echo "go build -o gogs"
          echo $BUILD_NUMBER
        '''
      }
    }
    stage('Build Image') {
      agent any
        steps {
            sh 'docker build -t infinityofcore/testgogs:$BUILD_NUMBER build.Dockerfile'
      }
    }
    stage('Push Image') {
      agent any
        steps {
            withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_HUB_PWD', usernameVariable: 'DOCKER_HUB_USER')]) {
                sh "docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PWD"
                sh 'docker push infinityofcore/testgogs'
            }
        }
    }
  }
}
