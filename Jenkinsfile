pipeline {
    agent any
    stages {
        stage('1') {
            steps {
                sh "docker build -t ${params.DOCKERHUB_REPO}/${params.TAG} ."
            }
        }
        stage('2') {
            steps {
                sh "docker login -u dhiaabdelli -p ${params.DOCKERHUB_PWD}"
                sh "docker push ${params.DOCKERHUB_REPO}/${params.TAG}"
            }
        }
    }
}

