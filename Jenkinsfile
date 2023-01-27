pipeline {
  agent { dockerfile true }
  stages {
    stage('Clone repository') {
      

        checkout scm
    }

    stage('Build image') {

       sh 'pwd'
       sh 'ls'
        withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin", "CGO_ENABLED=0"]) {
        sh 'go build -o gogs'
        
      }
    }
    stage('test image') {
       sh 'pwd'
       sh 'ls'
       withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
        sh 'go test ./...'
        } 
    }


    stage('Push Image') {
        app = docker.build("infinityofcore/testgogs")
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
        }
    }
    
    stage('Trigger ManifestUpdate') {
                echo "triggering updatemanifestjob"
                build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
        }
}
}
