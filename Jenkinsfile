pipeline {
    agent any

    stages {
        stage('Build (Install Deps)') {
            steps {
                echo 'Creating Virtual Environment & Installing Requirements...'
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Test (Smoke Check)') {
            steps {
                echo 'Running a Smoke Test...'
                sh '''
                    . venv/bin/activate
                    python3 -c "import fastapi; print('✅ FastAPI is installed and ready!')"
                '''
            }
        }
    }
}
