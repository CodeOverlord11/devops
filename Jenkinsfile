pipeline {
    agent any

    environment {
        IMAGE_NAME     = 'static-site'
        CONTAINER_NAME = 'static-site-container'
        APP_PORT       = '80'
    }

    stages {

        stage('Checkout') {
            steps {
                echo '📥 Pulling latest code from GitHub...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building nginx Docker image...'
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Stop Old Container') {
            steps {
                echo '🛑 Removing old container if running...'
                sh '''
                    docker stop $CONTAINER_NAME || true
                    docker rm   $CONTAINER_NAME || true
                '''
            }
        }

        stage('Deploy New Container') {
            steps {
                echo '🚀 Starting new container...'
                sh '''
                    docker run -d \
                        --name $CONTAINER_NAME \
                        -p $APP_PORT:80 \
                        --restart unless-stopped \
                        $IMAGE_NAME:latest
                '''
            }
        }

        stage('Health Check') {
            steps {
                echo '✅ Checking site is reachable...'
                sh '''
                    sleep 3
                    curl -f http://localhost:$APP_PORT || (echo "❌ Health check failed!" && exit 1)
                '''
            }
        }

    }

    post {
        success {
            echo '🎉 Deployment successful! Your site is live.'
        }
        failure {
            echo '❌ Pipeline failed. Check the logs above.'
        }
        always {
            echo '🧹 Pruning unused Docker images...'
            sh 'docker image prune -f || true'
        }
    }
}
