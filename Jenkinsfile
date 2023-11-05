pipeline {
    agent any
    stages {
        stage('1') {
            steps {
                sh 'docker build -t dhiaabdelli/achat:1.0.0 .'
            }
        }
        stage('2') {
            steps {
                script {
                    def PWD = params.DOCKERHUB_PWD
                    sh 'docker login -u dhiaabdelli -p ${PWD}'
                    sh 'docker push dhiaabdelli/achat:1.0.0'
                }
            }
        }
    }
}

