pipeline {
	agent any
	stages {
		stage('MAVEN CLEAN'){
			steps{
				sh 'mvn clean'
			}
		}
		stage ('MAVEN COMPILE'){
			steps{
				sh 'mvn compile'
			}
		}
	}
}
