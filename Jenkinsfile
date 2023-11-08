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
                echo "${params.DOCKERHUB_PWD}"
                //sh 'docker login -u dhiaabdelli -p \$params.DOCKERHUB_PWD'
                //sh 'docker push dhiaabdelli/achat:1.0.0'
            }
        }
    }
}

