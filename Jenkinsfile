pipeline {
    agent any
    stages {
        stage('Launching Sonarqube') {
            steps {
                sh 'docker compose up -d sonarqube'
            }
        }
        stage('Building Project') {
            steps {
                sh 'mvn clean'
                sh 'mvn compile'
                sh 'mvn package'
            }
        }

        stage('Code Quality check') {
            steps {
                sh "mvn sonar:sonar -Dsonar.login=${params.SONAR_LOGIN} -Dsonar.password=${SONAR_PWD} -Dsonar.host.url=http://localhost:9000"
            }
        }
        stage('Building and pushing docker image') {
            steps {
                sh "docker build -t ${params.DOCKERHUB_USERNAME}/${params.IMG_NAME}:${IMG_TAG} ."
                sh "docker login -u ${params.DOCKERHUB_USERNAME} -p ${params.DOCKERHUB_PWD}"
                sh "docker push ${params.DOCKERHUB_USERNAME}/${params.IMG_NAME}:${IMG_TAG}"
            }
        }
        stage('NEXUS DEPLOY') {
            steps {
                sh 'mvn deploy'
            }
        }
        stage('Launching Project') {
            steps {
                sh 'docker compose up -d app-achat'
            }
        }
        stage('Launching Monitoring services') {
            steps {
                sh 'docker compose up -d prometheus grafana'
            }
        }
    }
    post {
            failure {
                script {
                    sh 'docker compose down'
                }
            }
    }
}
