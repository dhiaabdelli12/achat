pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dhiaabdelli-dockerhub')
        DOCKERHUB_IMAGE_NAME = 'dhiaabdelli/achat'
        DOCKERHUB_IMAGE_TAG = '1.0.0'
    }

    stages {
        stage('Building') {
            steps {
                sh 'mvn clean'
                sh 'mvn compile'
            }
        }
        stage('Code Quality check') {
            steps {
                sh "mvn sonar:sonar -Dsonar.login=${params.SONAR_LOGIN} -Dsonar.password=${SONAR_PWD} -Dsonar.host.url=http://sonarqube:9000"
            }
        }
        /*stage('MAVEN DEPLOY') {
            steps {
            //sh 'mvn deploy'
            }
        }*/
        stage('Building and pushing docker image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dhiaabdelli-dockerhub') {
                        // Push the Docker image to Docker Hub
                        dockerImage.push("${DOCKER_IMAGE_TAG}")
                    }
                }
            }
        }
    }
}
    /*post {
        always {
            script {
                sh 'docker compose down'
            }
        }
    }*/

