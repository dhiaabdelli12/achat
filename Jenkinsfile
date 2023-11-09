pipeline {
    agent any
    stages {
        stage('Launching Containers') {
            steps {
                sh 'docker compose up -d nexus sonarqube prometheus grafana'
            }
        }
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
        stage('Building Docker Image') {
            steps {
                sh "docker build -t ${params.DOCKERHUB_REPO}/${params.TAG} ."
            }
        }
        stage('Pushing Docker Image') {
            steps {
                sh "docker login -u ${params.DOCKERHUB_REPO} -p ${params.DOCKERHUB_PWD}"
                sh "docker push ${params.DOCKERHUB_REPO}/${params.TAG}"
            }
        }
    }
}
