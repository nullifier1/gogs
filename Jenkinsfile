node(dockerNode image: 'node:16-alpine') {
    def root = sh(script: 'go version', returnStdout: true).trim()
    withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
        // Output will be something like "go version go1.19 darwin/arm64"
        sh 'go version'
    }
    stage('Clone repository') {
        checkout scm
    }
    }
    stage('test image') {
        sh 'pwd'
        sh 'ls'
        withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
            sh 'go test ./...'
        } 
    }
    stage('Trigger ManifestUpdate') {
        echo "triggering updatemanifestjob"
        build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
    }
}

