pipeline {
  agent { node { label 'docker' }}
  options { skipDefaultCheckout() }
  stages {
    stage('Checkout') {
        steps {
            dir('toggleR') {
                checkout scm
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
                sh 'docker run -v $PWD:/toggleR -w /toggleR --env TOGGL_TOKEN --env TOGGL_WORKSPACE tidyverse-test R CMD check toggleR_0.0.0.9000.tar.gz'
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