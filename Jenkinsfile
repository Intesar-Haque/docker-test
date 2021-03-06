pipeline {
    environment {
        registry = "intesar99/devops"
        registryCredential = 'docker-hub-id'
        dockerImage = ''
    }
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    stages {
        stage('Cloning From Git') {
            steps {
                git 'https://github.com/Intesar-Haque/docker-test.git'
            }
        }

        stage('Scanning') {
          steps {
            withSonarQubeEnv(installationName: 'sonar-qube') {
              sh './mvnw clean sonar:sonar'
            }
          }
        }
        stage('Building image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploying') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
//         stage('Creating Server') {
//             steps{
//                 sh "docker run -p 1000 "
//             }
//         }
//         stage('Deploying to Kubernetes') {
//             steps{
//                 sh "kubectl expose deployment webserver --type=LoadBalancer --port=9000"
//             }
//         }
        stage('Cleaning up') {
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}
