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
                dir ('toggleR/docker-test') {
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
    stage('Docker Image') {
        when {
            branch 'master'
        }
        steps {
            withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'passwd', usernameVariable: 'user')]) {
                dir('toggleR/docker-build') {
                    sh '''
                    version=$(head -1 ../version.r)
                    docker build  -t praqma/toggler:$version .
                    docker images
                    docker login -u releasepraqma -p $passwd
                    docker push praqma/toggler:$version
                    '''
                }
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