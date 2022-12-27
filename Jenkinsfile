node {
    def app
    def root = tool type: 'go', name: '1.19.4'
    withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
        // Output will be something like "go version go1.19 darwin/arm64"
        sh 'go version'
    }
    stage('Clone repository') {
      

        checkout scm
    }

    stage('Build image') {
       sh 'pwd'
       sh 'ls'
        withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
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


    stage('Deploy') {
        sh "ssh vagrant@192.168.13.109 rm -rf /home/vagrant/gogs/*"
        sh 'pwd'
        sh 'ls'
        sh 'ssh vagrant@192.168.13.109 mkdir -p /home/vagrant/gogs/custom/conf'
        sh "scp gogs vagrant@192.168.13.109:/home/vagrant/gogs/"
        sh "scp custom/conf/app.ini vagrant@192.168.13.109:/home/vagrant/gogs/custom/conf" 
        sh 'ssh vagrant@192.168.13.109 /home/vagrant/gogs/gogs web > /dev/null 2>&1 & '

        }
    }
