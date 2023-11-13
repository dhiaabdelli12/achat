pipeline {
    agent any
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

        stage('Building and pushing docker image') {
            steps {
                sh "docker build -t ${params.DOCKERHUB_USERNAME}/${params.IMG_NAME}:${IMG_TAG} /usr/app"
                sh "docker login -u ${params.DOCKERHUB_USERNAME} -p ${params.DOCKERHUB_PWD}"
            }
        }
        stage('NEXUS DEPLOY') {
            steps {
                sh 'mvn deploy'
            }
        }
    }
}
    

