pipeline {
  agent { dockerfile true }
  stages {
    stage('Test') {
      steps {
        sh '''
          echo "go test ./..."
        '''
      }
    }
    stage('build') {
      steps {
        sh '''
          export CGO_ENABLED=0
          echo "go build -o gogs"
          echo $BUILD_NUMBER
        '''
      }
    }
     stage('Trigger Other Pipeline') {
         steps {
             build job: 'updatemanifest', parameters: [
                 string(name: 'DOCKERTAG', value: '${env.BUILD_NUMBER}'),
                ]
}
}
}
}
