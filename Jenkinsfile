pipeline {

    agent any

  

    stages {
        stage("Checking the code") {
            steps {
                git branch: "main", url: "https://github.com/sharieffzain/DKProject.git"
            }
        }

        
        

        stage("Building the Dockerfile") {
            steps {
                script {
                    dir(PROJECT_DIR) {
                        sh 'docker build -t webapp:01 .'
                    }
                }
            }
        }

        stage("Running the Docker Image") {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                ]){
                     script {
                        sh """ 
                        docker run -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
                                       -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
                                       -e AWS_REGION=ap-south-2 \
                                       -e SNS_TOPIC_ARN=${env.SNS_TOPIC_ARN} \
                                       -p 5000:5000 \
                                       -d flask-todo-dynamo:v1
                        """
                    }
                }    
            }   
        }
    }
}
