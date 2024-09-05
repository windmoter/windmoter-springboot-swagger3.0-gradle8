pipeline {
    agent any

    stages {
        stage('Checkout---') {
            steps {
                // GitHub 저장소에서 코드 체크아웃
                git 'https://github.com/windmoter/springboot-swagger3.0.git'
            }
        }

        stage('Build---') {
            steps {
                // Maven을 사용하여 빌드
                sh 'mvn clean package'
            }
        }

        stage('Test---') {
            steps {
                // Maven을 사용하여 테스트 실행
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                // 배포 단계 (예: AWS S3에 업로드)
                echo 'Deploying application...'
                // 배포 명령어 추가
            }
        }
    }

    post {
        success {
            echo 'Build and deployment succeeded!'
        }
        failure {
            echo 'Build or deployment failed.'
        }
    }
}
