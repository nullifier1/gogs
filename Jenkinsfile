node {
    def app
    tools { go '1.19' }
    stage('Clone repository') {
      

        checkout scm
    }

    stage('Build image') {
       sh 'pwd'
       sh 'ls'
       sh 'go build -o gogs'
      
    }
    stage('test image') {
       sh 'pwd'
       sh 'ls'
       sh 'go test ./...'
    }


    stage('Push image') {
        app = docker.build("infinityofcore/test")
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
        }
    }
    
    stage('Trigger ManifestUpdate') {
                echo "triggering updatemanifestjob"
                build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
        }
}
