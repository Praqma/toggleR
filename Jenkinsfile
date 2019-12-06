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
            expression { readFile('toggleR/version.r').trim() ==~ /\d+.\d+.\d+/ }
        }
        steps {
            withCredentials([string(credentialsId: 'praqmarelease', variable: 'TOGGLER_TOKEN')]) {
                sh '''
                version=$(head -1 toggleR/version.r)
                message=$(cat toggleR/message.txt)
                toggleR/release.sh $version $message
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