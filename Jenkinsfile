pipeline {
    agent any

    environment {
        // ✅ CHANGE THESE TO YOUR VALUES
        DOCKER_HUB_USER    = 'your-dockerhub-username'
        DOCKER_IMAGE_NAME  = 'mahesh-shopping'
        DOCKER_IMAGE_TAG   = "${BUILD_NUMBER}"
        FULL_IMAGE         = "${DOCKER_HUB_USER}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
        CONTAINER_NAME     = 'mahesh-shopping-app'
        APP_PORT           = '9090'          // host port → maps to container 8080
        GIT_REPO_URL       = 'https://github.com/your-username/mahesh-shopping.git'
        GIT_BRANCH         = 'main'
    }

    stages {

        // ─────────────────────────────────────────────
        // STAGE 1: Fetch Code from GitHub
        // ─────────────────────────────────────────────
        stage('1. Fetch Code from GitHub') {
            steps {
                echo '📥 Cloning source code from GitHub...'
                git branch: "${GIT_BRANCH}",
                    credentialsId: 'git-credentials',   // Jenkins credential ID
                    url: "${GIT_REPO_URL}"
                echo '✅ Code fetched successfully!'
            }
        }

        // ─────────────────────────────────────────────
        // STAGE 2: Build WAR File (Maven)
        // ─────────────────────────────────────────────
        stage('2. Build WAR File') {
            steps {
                echo '🔨 Building WAR file with Maven...'
                sh 'mvn clean package -DskipTests'
                echo '✅ WAR file built successfully!'
            }
            post {
                success {
                    // Archive the WAR as a Jenkins artifact
                    archiveArtifacts artifacts: 'target/*.war', fingerprint: true
                    echo '📦 WAR archived as Jenkins artifact'
                }
            }
        }

        // ─────────────────────────────────────────────
        // STAGE 3: Build Custom Docker Image
        // ─────────────────────────────────────────────
        stage('3. Build Docker Image') {
            steps {
                echo "🐳 Building Docker image: ${FULL_IMAGE}"
                sh """
                    docker build -t ${FULL_IMAGE} .
                    docker tag ${FULL_IMAGE} ${DOCKER_HUB_USER}/${DOCKER_IMAGE_NAME}:latest
                """
                echo '✅ Docker image built successfully!'
                sh "docker images | grep ${DOCKER_IMAGE_NAME}"
            }
        }

        // ─────────────────────────────────────────────
        // STAGE 4: Push Image to Docker Hub
        // ─────────────────────────────────────────────
        stage('4. Push to Docker Hub') {
            steps {
                echo '📤 Pushing Docker image to Docker Hub...'
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',   // Jenkins credential ID
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${FULL_IMAGE}
                        docker push ${DOCKER_HUB_USER}/${DOCKER_IMAGE_NAME}:latest
                        docker logout
                    """
                }
                echo "✅ Image pushed: ${FULL_IMAGE}"
            }
        }

        // ─────────────────────────────────────────────
        // STAGE 5: Pull from Docker Hub & Run Container
        // ─────────────────────────────────────────────
        stage('5. Deploy - Pull & Run Container') {
            steps {
                echo '🚀 Deploying container from Docker Hub...'
                sh """
                    # Stop and remove existing container if running
                    docker stop ${CONTAINER_NAME} || true
                    docker rm   ${CONTAINER_NAME} || true

                    # Remove old local image (optional - forces fresh pull)
                    docker rmi ${FULL_IMAGE} || true

                    # Pull latest image from Docker Hub
                    docker pull ${FULL_IMAGE}

                    # Run the container
                    docker run -d \\
                        --name ${CONTAINER_NAME} \\
                        -p ${APP_PORT}:8080 \\
                        --restart unless-stopped \\
                        ${FULL_IMAGE}

                    echo "⏳ Waiting for Tomcat to start..."
                    sleep 20
                """
                echo '✅ Container is running!'
                sh "docker ps | grep ${CONTAINER_NAME}"
            }
        }

        // ─────────────────────────────────────────────
        // STAGE 6: Health Check - Verify App is Live
        // ─────────────────────────────────────────────
        stage('6. Health Check') {
            steps {
                script {
                    echo '🔍 Checking application health...'
                    def response = sh(
                        script: "curl -s -o /dev/null -w '%{http_code}' http://localhost:${APP_PORT}/mahesh-shopping/",
                        returnStdout: true
                    ).trim()

                    if (response == '200') {
                        echo "✅ App is LIVE! HTTP Status: ${response}"
                    } else {
                        echo "⚠️  App responded with HTTP: ${response}"
                        echo "Check logs: docker logs ${CONTAINER_NAME}"
                    }
                }
            }
        }

        // ─────────────────────────────────────────────
        // STAGE 7: Deployment Summary
        // ─────────────────────────────────────────────
        stage('7. Deployment Summary') {
            steps {
                script {
                    def publicIP = sh(
                        script: "curl -s http://checkip.amazonaws.com || echo 'YOUR-EC2-IP'",
                        returnStdout: true
                    ).trim()

                    echo """
╔══════════════════════════════════════════════════╗
║         🛍️  MAHESH SHOPPING - DEPLOYED!          ║
╠══════════════════════════════════════════════════╣
║  Build Number  : ${BUILD_NUMBER}
║  Docker Image  : ${FULL_IMAGE}
║  Container     : ${CONTAINER_NAME}
║  Host Port     : ${APP_PORT}
╠══════════════════════════════════════════════════╣
║  🌐 ACCESS URL:                                  ║
║  http://${publicIP}:${APP_PORT}/mahesh-shopping/
╚══════════════════════════════════════════════════╝
                    """
                }
            }
        }
    }

    // ─────────────────────────────────────────────
    // POST ACTIONS
    // ─────────────────────────────────────────────
    post {
        success {
            echo '🎉 Pipeline SUCCEEDED! Mahesh Shopping is live!'
        }
        failure {
            echo '❌ Pipeline FAILED! Check logs above.'
            sh "docker logs ${CONTAINER_NAME} || true"
        }
        always {
            echo '🧹 Cleaning up unused Docker images...'
            sh 'docker image prune -f || true'
        }
    }
}
