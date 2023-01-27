pipeline {
  agent none
  stages {
    stage('Test') {
      agent { dockerfile true}
      steps {
        sh '''
          go test ./...
        '''
      }
    }
    stage('build') {
      agent { dockerfile true}
      steps {
        sh '''
          export CGO_ENABLED=0
          go build -o gogs
        '''
      }
    }
    stage('Build Image') {
      agent any
        steps {
            sh 'docker build -f build.Dockerfile -t infinityofcore/testgogs:$BUILD_NUMBER .'
            sh 'export CONTAINER_NUMBER=$BUILD_NUMBER'
            sh 'echo $CONTAINER_NUMBER'
      }
    }
    stage('Push Image') {
      agent any
        steps {
            withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_HUB_PWD', usernameVariable: 'DOCKER_HUB_USER')]) {
                sh "docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PWD"
                sh 'docker push infinityofcore/testgogs'
            }
    stage('Trigger Other Pipeline') {
       steps {
          build job: 'updatemanifest', parameters: [
                 string(name: 'DOCKERTAG', value: '$CONTAINER_NUMBER'),
                ]
   }
    }
    }
  }
}
