pipeline{ 
    agent any
    environment {
        SCRIPT_PATH = '/var/jenkins_home/custom/snapcampus'
    }
    tools {
        gradle 'gradle 8.6'
    }
    stages{
        stage('Start') {
            steps {
                echo 'Pipeline ...go'
            }
        }
        stage('Checkout') {
            steps {
                echo 'Checkout...'
                checkout scm
            }
        }
        stage('Prepare'){
            steps {
                echo 'Prepare...'
                sh 'gradle clean'
            }
        }
        stage('Replace Prod Properties') {
            steps {
                echo 'Replace Prod Properties...'
                withCredentials([file(credentialsId: 'snapCampusProd', variable: 'snapCampusProd')]) {
                    script {
                        sh 'cp $snapCampusProd ./src/main/resources/application-prod.yml'
                    }
                }
            }
        }
        stage('Build') {
            steps {
                echo 'Build..'
                sh 'gradle build -x test'
            }
        }
        stage('Test') {
            steps {
                echo 'Test..'
                sh 'gradle test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploy..'
                sh '''
                    cp ./docker/docker-compose.blue.yml ${SCRIPT_PATH}
                    cp ./docker/docker-compose.green.yml ${SCRIPT_PATH}
                    cp ./docker/Dockerfile ${SCRIPT_PATH}
                    cp ./scripts/deploy.sh ${SCRIPT_PATH}
                    cp ./build/libs/*.jar ${SCRIPT_PATH}
                    chmod +x ${SCRIPT_PATH}/deploy.sh
                    ${SCRIPT_PATH}/deploy.sh
                '''
            }
        }
    }
}