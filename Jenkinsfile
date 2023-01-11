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
        sh "ssh vagrant@192.168.13.109 rm -rf /home/vagrant/gogs/*"
        sh 'ssh vagrant@192.168.13.109 mkdir -p /home/vagrant/gogs/custom/conf'
        sh "scp gogs vagrant@192.168.13.109:/home/vagrant/gogs/"
        sh "scp custom/conf/app.ini vagrant@192.168.13.109:/home/vagrant/gogs/custom/conf" 
        sh 'ssh vagrant@192.168.13.109 /home/vagrant/gogs/gogs web > /dev/null 2>&1 & '

        sh "ssh vagrant@192.168.13.108 rm -rf /home/vagrant/gogs/*"
        sh 'ssh vagrant@192.168.13.108 mkdir -p /home/vagrant/gogs/custom/conf'
        sh "scp gogs vagrant@192.168.13.108:/home/vagrant/gogs/"
        sh "scp custom/conf/app.ini vagrant@192.168.13.108:/home/vagrant/gogs/custom/conf" 
        sh 'ssh vagrant@192.168.13.108 /home/vagrant/gogs/gogs web > /dev/null 2>&1 & '
        }
    }
