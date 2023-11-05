pipeline {
    agent any
    stages {
        stage('BUILD') {
            steps {
                sh 'mvn clean'
                sh 'mvn compile'
            }
        }
        stage('TESTING') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.login=squ_a0d08a213d3150623d90598bab2760dca76030e7'
            }
        }
        /*stage('MAVEN COMPILE') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('MAVEN SONARQUBE') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.login=squ_a0d08a213d3150623d90598bab2760dca76030e7'
            }
        }
        stage('MAVEN DEPLOY') {
            steps {
                sh 'mvn deploy'
            }
        }
    */}
}
