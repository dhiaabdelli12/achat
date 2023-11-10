pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = ${ params.DOCKERHUB_REPO }
        DOCKER_IMAGE_NAME = 'achatimage'
        DOCKER_IMAGE_TAG = 'latest'
    }

    stages {
        stage('Code Quality check') {
            steps {
                sh "mvn sonar:sonar -Dsonar.login=${params.SONAR_LOGIN} -Dsonar.password=${SONAR_PWD}"
            }
        }
        stage('Building') {
            steps {
                sh 'mvn clean'
                sh 'mvn compile'
            }
        }
        stage('MAVEN DEPLOY') {
            steps {
                sh 'mvn deploy'
            }
        }
        stage('Building and pushing docker image') {
            steps {
                script {
                    docker.withRegistry("https://${DOCKER_REGISTRY}", '') {
                        def customImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                        customImage.push()
                    }
                }
            }
        }
    }
    /*post {
        always{
            script{
            //sh 'docker compose down'
            }
        }
    }*/
}
