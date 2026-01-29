pipeline {
    agent any

    stages {
        stage('Build (Install Deps)') {
            steps {
                echo 'Installing requirements...'
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Test (Smoke Check)') {
            steps {
                echo 'Running Smoke Test...'
                sh '''
                    . venv/bin/activate
                    python3 -c "import fastapi; print('✅ FastAPI is ready!')"
                '''
            }
        }

        stage('Build Docker Artifact') {
            steps {
                echo 'Building Docker Image...'
                // This builds the image and tags it as "hms-app" with the current Build Number
                // Example: hms-app:v4
                sh "docker build -t hms-app:v${BUILD_NUMBER} ." 
            }
        }
    }

    post {
        always {
            // Cleanup: Remove the image to save space on the server
            // In a real job, you would PUSH this to DockerHub first, then delete.
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}
