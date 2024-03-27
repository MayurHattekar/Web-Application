pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "mayurh1993/web-application"
    }
    stages {
        stage('Build Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jenkins-user-for-docker-login', passwordVariable: 'PASSWD', usernameVariable: 'USER')]) {
                    sh 'docker build --build-arg USER=${USER} --build-arg PASSWD=${PASSWD} -t web-application .'
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerHub') {
                        def app = docker.build DOCKER_IMAGE
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerHub') {
                        def app = docker.image(DOCKER_IMAGE)
                        app.pull('latest')
                        app.run('-d -p 8080:8080')
                    }
                }
            }
        }
    }
}
