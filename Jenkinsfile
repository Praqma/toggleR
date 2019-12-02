pipeline {
  agent { node { label 'docker' }}
  options { skipDefaultCheckout() }
  stages {
    stage('Checkout') {
        steps {
            dir('toggleR') {
                checkout scm
                sh './version.sh'
            }
            script {
                currentBuild.description = readFile('toggleR/version.txt')
            }
        }
    }
    stage('Build') {
        steps {
            sh 'docker run -v $PWD:/toggleR -w /toggleR rocker/tidyverse R CMD build toggleR'
        }
    }
    stage('Check') {
        steps {
            catchError {
                dir ('toggleR') {
                    sh 'docker build -t tidyverse-test .'
                }
                sh 'docker run -v $PWD:/toggleR -w /toggleR --env TOGGL_TOKEN --env TOGGL_WORKSPACE tidyverse-test R CMD check toggleR_$(cat toggleR/version.r).tar.gz'
            }
        }
    }
    stage('Release') {
        when {
            branch 'master'
            expression { readFile('toggleR/version.r') ==~ /\d.\d.\d/ }
        }
        steps {
            withCredentials([string(credentialsId: 'praqmarelease', variable: 'PraqmaRelease')]) {
                sh '''
                version=$(cat toggleR/version.r
                url="https://uploads.github.com/repos/Praqma/toggleR/releases/$version/assets?name=$version&tag_name=$version"
                curl -X POST \
                 --data-binary @toggleR_$version.tar.gz \
                 -H "Authorization: token $PraqmaRelease" \
                 -H "Content-Type: application/octet-stream" $url
                '''
            }
        }
    }
  }
  post {
        always {
            archiveArtifacts artifacts: 'toggleR.Rcheck/, toggleR*.tar.gz'
        }
    }
}