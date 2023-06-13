/*pipeline{
    agent { 
        label "docker-agent"
    }
    stages{
        stage("Verify Docker and Docker Compose"){
            steps{
                sh '''
                    docker version
                    docker info
                    docker compose version
                '''
            }
        }
        stage("Start Application with Docker Compose"){
            steps{
                sh ' docker compose up -d'
            }
        }
    }
}*/
pipeline {

  agent {
    label 'docker-agent'
  }

    environment {
        registry = "lochub/imagewebphp"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }

  stages {
    
     stage("Verify Docker and Docker Compose"){
            steps{
                sh '''
                    docker version
                    docker info
                    docker compose version
                '''
            }
        }
     stage('Build docker image') {
        steps {
            script {
            dockerImage = docker.build registry
        }
      }
    }

    stage('Upload Image') {
        steps{   
            script {
            docker.withRegistry('', registryCredential) {
            dockerImage.push()
            dockerImage.push('latest')
            }
        }
      }
    }

    stage('K8S Deploy') {
        steps {
            script {
                withKubeConfig([credentialsId: 'K8S', serverUrl: '']) {
                sh ('kubectl apply -f  deployPHPweb.yaml')
                sh ('kubectl apply -f  mysql-pv.yaml')
                sh ('kubectl apply -f  mysql-deployment.yaml')
                }
            }
        }
    }
}
}
