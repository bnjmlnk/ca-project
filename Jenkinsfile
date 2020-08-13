pipeline {
  agent any
  environment {
    docker_username = 'bnjmlnk'
  }
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
    stage('Parallel execution') {
      parallel {
        stage('Create artifact') {
          steps {
            sh 'mkdir archive'
            sh 'echo test > archive/test.txt'
            zip zipFile: 'codechan_artifacts.zip', archive: false, dir: 'archive' 
            archiveArtifacts artifacts: 'codechan_artifacts.zip'
            sh 'ls'
          }
        }
        stage('push docker') {
          environment {
            DOCKERCREDS = credentials('docker_login') //use the credentials just created in this stage
          }
          options {
            skipDefaultCheckout()
          }
          steps {
            unstash 'code' //unstash the repository code
            sh 'docker build -t bnjmlnk/codechan .'
            sh 'echo "$DOCKERCREDS_PSW" | docker login -u "$DOCKERCREDS_USR" --password-stdin' //login to docker hub with the credentials above
            sh 'docker push bnjmlnk/codechan'
          }
        }
      }
    }
    

  }
}