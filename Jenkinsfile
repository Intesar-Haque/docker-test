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
        stage('Cloning our Git') {
            steps {
                git 'https://github.com/Intesar-Haque/docker-test.git'
            }
        }
        stage('Scan') {
          steps {
            withSonarQubeEnv(installationName: 'sonar-qube') {
              sh './mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'
            }
          }
        }
        stage('Building our image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploying to dockerhub') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
//         stage('Mounting to Kubernetes') {
//             steps{
//                 sh "kubectl create deployment webserver --image=$registry:$BUILD_NUMBER"
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
