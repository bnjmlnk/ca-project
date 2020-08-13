pipeline {
  agent any
  stages {
    stage('Clone down') {
      steps {
        stash excludes: '.git/', name: 'code'
      }
    }
    stage('Say Hello') {
      steps {
        sh 'echo "Hello World!"'
      }
    }
    stage('Test app') {
          options {
            skipDefaultCheckout()
          }
          agent {
            docker {
              image 'python:3.8.5-slim-buster'
            }
          }
          steps {
            unstash 'code'
            sh 'pip install -r requirements.txt'
            sh 'python tests.py'
          }
        }
    stage('Paralel execution') {
      parallel {
        stage('Create artifact') {
          steps {
            sh 'mkdir app/build/libs'
            zip zipFile: 'codechan_artifacts.zip', archive: false, dir: 'app/build/libs' 
            archiveArtifacts artifacts: 'codechan_artifacts.zip'
            sh 'ls'
          }
        }
      }
    }    

  }
}