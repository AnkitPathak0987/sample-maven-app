pipeline {
    agent any   // Run on any available Jenkins agent (Windows-friendly)

    environment {
        // ✅ Your DockerHub repo
        DOCKER_HUB_REPO = 'ankit106/sample-maven-app'
    }

    stages {
        // ----------------------------
        // 1️⃣ Checkout Stage
        // ----------------------------
        stage('Checkout') {
            steps {
                echo 'Cloning GitHub repository...'
                git branch: 'main',
                    url: 'https://github.com/AnkitPathak0987/sample-maven-app.git',
                    credentialsId: 'github-creds'
            }
        }

        // ----------------------------
        // 2️⃣ Build Stage
        // ----------------------------
        stage('Build') {
            steps {
                echo 'Building project using Maven...'
                bat 'mvn -B clean compile'
            }
        }

        // ----------------------------
        // 3️⃣ Test Stage
        // ----------------------------
        stage('Test') {
            steps {
                echo 'Running test cases...'
                bat 'mvn -B test'
            }
        }

        // ----------------------------
        // 4️⃣ Package Stage
        // ----------------------------
        stage('Package') {
            steps {
                echo 'Packaging the application...'
                bat 'mvn -B package -DskipTests'
            }
        }

        // ----------------------------
        // 5️⃣ Docker Build Stage
        // ----------------------------
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    bat "docker build -t %DOCKER_HUB_REPO%:latest ."
                }
            }
        }

        // ----------------------------
        // 6️⃣ Push to Docker Hub
        // ----------------------------
        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    
                    bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                    bat "docker push %DOCKER_HUB_REPO%:latest"
                }
            }
        }

        // ----------------------------
        // 7️⃣ (Optional) Deploy to EC2
        // ----------------------------
        /*
        stage('Deploy (Optional)') {
            when { expression { env.AWS_DEPLOY == 'true' } }
            steps {
                echo 'Deploying Docker container on EC2...'
                script {
                    sshagent(credentials: ['aws-key']) {
                        bat '''
                        plink -i C:\\path\\to\\your\\pem-converted-putty.ppk ec2-user@<EC2_PUBLIC_IP> ^
                        "docker pull %DOCKER_HUB_REPO%:latest && docker stop myapp || true && docker rm myapp || true && docker run -d --name myapp -p 80:80 %DOCKER_HUB_REPO%:latest"
                        '''
                    }
                }
            }
        }
        */
    }

    // ----------------------------
    // ✅ Post Actions
    // ----------------------------
    post {
        success {
            echo '✅ Pipeline completed successfully.'
        }
        failure {
            echo '❌ Pipeline failed! Check logs for details.'
        }
    }
}
