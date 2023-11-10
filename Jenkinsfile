pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "${ params.DOCKERHUB_REPO }"
        DOCKER_IMAGE_NAME = 'achatimage'
        DOCKER_IMAGE_TAG = 'latest'
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
        stage('MAVEN DEPLOY') {
            steps {
                //sh 'mvn deploy'
            }
        }
        stage('Building and pushing docker image') {
            steps {
                    sh 'docker build -t dhiaabdelli/achat:1.0.0 .'
                }
            }
        }
    }
    post {
        always {
            script {
                sh 'docker compose down'
            }
        }
    }
}
