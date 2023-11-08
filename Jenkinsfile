pipeline {
    agent any
    stages {
        stage('Code Quality check'){
            sh "mvn sonar:sonar -Dsonar.login=${params.SONAR_LOGIN}"
        }
        stage('Launching Containers'){
            sh "docker compose up"
        }
        stage('Building'){
            sh 'mvn clean'
            sh 'mvn compile'
        }
        stage('Building Docker Image') {
            steps {
                sh "docker build -t ${params.DOCKERHUB_REPO}/${params.TAG} ."
            }
        }
        stage('Pushing Docker Image') {
            steps {
                sh "docker login -u dhiaabdelli -p ${params.DOCKERHUB_PWD}"
                sh "docker push ${params.DOCKERHUB_REPO}/${params.TAG}"
            }
        }
    }
}

