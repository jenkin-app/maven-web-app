pipeline {
    agent any

    tools {
        // Install the Maven 
        maven "maven3.8"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                //git 'https://github.com/jenkin-app/maven-web-app.git'

                // Run Maven 
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }    
        stage('Build docker image') {
            steps {
                script {
                    def DOCKER_IMAGE = 'esso4real/pipeline:v29'
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-id', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
    
                    sh "docker build -t ${DOCKER_IMAGE} ." 
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}"
                    }
                }
            }
        }
        stage('Provisioning server') {
            steps{
                script{
                    sh "terraform init"
                    sh "terraform apply --auto-approve"
                }
            }
        }
        stage ('Deploy') {
        steps {
            script {
            def REMOTE_USER = 'ec2-user' 
            def REMOTE_HOST = '54.204.49.238'
            sh "ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST}"
            sh "scp -o StrictHostKeyChecking=nodeploy.sh ${REMOTE_USER}@${REMOTE_HOST}:~/"
            sh "ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} 'chmod +x deploy.sh'"
            sh "ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} ./deploy.sh"
            }
        }
    }             
}

}
