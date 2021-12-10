pipeline {
    environment {
        registry = "intesar99/devops"
        registryCredential = 'docker-hub-id'
        dockerImage = ''
    }
    agent any
    stages {
        stage('Cloning our Git') {
            steps {
                git 'https://github.com/Intesar-Haque/docker-test.git'
            }
        }
//         stage('Docker Build') {
//            agent any
//            steps {
//              sh "ls"
//              sh 'docker build -t spring .'
//              sh "ls"
//            }
//          }
        stage('Building our image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploying our image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Cleaning up') {
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}