node("agent01") {
    def app
    def root = tool type: 'go', name: '1.19.4'
    withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
        // Output will be something like "go version go1.19 darwin/arm64"
        sh 'go version'
    }
    stage('clone repository') {
      

        checkout scm
    }

    stage('build binary') {
        withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin", "CGO_ENABLED=0"]) {
        sh 'go build -o gogs'
        } 
    }
    stage('unit tests') {
       withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
        sh 'go test ./...'
        } 
    }


    stage('deploy') {
        sh "ssh jenkins@10.26.0.140 rm -rf /home/jenkins/gogs/*"
        sh 'ssh jenkins@10.26.0.140 mkdir -p /home/jenkins/gogs/custom/conf'
        sh "scp gogs jenkins@10.26.0.140:/home/jenkins/gogs"
        sh "scp custom/conf/app.ini jenkins@10.26.0.140:/home/jenkins/gogs/custom/conf" 
        sh 'ssh jenkins@10.26.0.140 /home/jenkins/gogs/gogs web > /dev/null 2>&1 & '

        sh "ssh jenkins@10.26.0.87 rm -rf /home/ssa/gogs*"
        sh 'ssh jenkins@10.26.0.87 mkdir -p /home/ssa/gogs/custom/conf'
        sh "scp gogs jenkins@10.26.0.87:/home/jenkins/gogs"
        sh "scp custom/conf/app.ini jenkins@10.26.0.87:/home/jenkins/gogs/custom/conf" 
        sh 'ssh jenkins@10.26.0.87 /home/jenkins/gogs/gogs web > /dev/null 2>&1 & '
        }
    }
