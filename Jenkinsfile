node(dockerNode image: 'node:16-alpine')
def app
def root = sh(script: 'go version', returnStdout: true).trim()

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
