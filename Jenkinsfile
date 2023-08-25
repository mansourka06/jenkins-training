// Build and run docker image with CI/CD as code
 
pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-webapp"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Building the Docker image with tag name
                    sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Stop and remove the existing container
                    sh "docker stop $IMAGE_NAME || true"
                    sh "docker rm $IMAGE_NAME || true"

                    // Running the built container
                    sh "docker run -d -p 80:80 --name $IMAGE_NAME $IMAGE_NAME:$IMAGE_TAG"
                }
            }
        }
    }

    post {
        always {
            // Clean up resources
            sh "docker stop $IMAGE_NAME || true"
            sh "docker rm $IMAGE_NAME || true"
        }
    }
}