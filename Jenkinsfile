pipeline {
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
          go build -o gogs
        '''
      }
    }
    stage('make image') {
      steps {
        sh '''
          ls
        '''
      }
    }
  }
}
