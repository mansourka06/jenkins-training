// Workflow for Building, Running and Pushing Docker image
pipeline {
    agent any

    environment {
        IMAGE_NAME = "alpinehelloworld"
        IMAGE_TAG = "latest"
    }

    stages {
        when {
               expression { GIT_BRANCH == 'origin/master' }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Building Docker image with name tag
                    sh "docker build -t $REGISTER_USER/$IMAGE_NAME:$IMAGE_TAG ."
                }
            }
        }

        stage('Deploy Docker Image') {
            steps {
                script {
                    // Stop and remove the existing container
                    sh "docker stop $IMAGE_NAME || true"
                    sh "docker rm $IMAGE_NAME || true"

                    // Running the built container
                    sh "docker run -d -p 80:80 --name $IMAGE_NAME $REGISTER_USER/$IMAGE_NAME:$IMAGE_TAG"
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    // Push the built container to registry
                    sh "curl http://localhost | grep -q "Hello world""
                }
            }
        }

    post {
        always {
            // Clean up resources
            sh '''
            echo "Cleanup ressources"
            docker stop $IMAGE_NAME || true
            docker rm $IMAGE_NAME || true
            '''
        }
    }
}
