pipeline {
  def app
  agent { dockerfile true }
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
    stage('Push Image') {
      app = docker.build("infinityofcore/test")
      docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
        app.push("${env.BUILD_NUMBER}")
    }
    }
  }
}
