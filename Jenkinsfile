pipeline {
    agent any
    stages {
        stage('Launching Sonarqube and nexus') {
            steps {
                sh 'docker compose up -d sonarqube nexus'
                waitForContainers()
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


def waitForContainers() {
    // Maximum time to wait for containers to become healthy (adjust as needed)
    def maxWaitTime = 300 // seconds
    def startTime = currentBuild.startTimeInMillis

    echo 'Waiting for containers to become healthy...'

    // Loop until all containers are healthy or timeout is reached
    timeout(time: maxWaitTime, unit: 'SECONDS') {
        boolean allContainersHealthy = false

        while (!allContainersHealthy) {
            def containerStatus = sh(script: 'docker-compose ps -q | xargs docker inspect --format \'{{.State.Health.Status}}\'', returnStatus: true).trim()

            // Check if all containers are healthy
            allContainersHealthy = containerStatus.split('\n').every { it == 'healthy' }

            if (!allContainersHealthy) {
                // Sleep for a short interval before checking again
                sleep(10)
            }
        }

        echo 'All containers are healthy!'
    }

    def elapsedTime = (currentBuild.startTimeInMillis - startTime) / 1000
    echo "Containers took ${elapsedTime} seconds to become healthy."
}