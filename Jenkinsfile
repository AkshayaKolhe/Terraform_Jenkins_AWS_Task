pipeline {
    agent any
    environment {
                aws_credentials = credentials('aws-credentials')      
        AWS_REGION = 'ap-south-1' 
    }
    tools {
        terraform 'terrafrom'
    }

    stages {
        stage('init') {
            steps {
                    sh 'terraform init -reconfigure -backend-config="bucket=bucket-for-tf-state-task-akshaya"'
            }
        }
        stage ("Action") {
            steps {   
                 script {
                    echo "Terraform action is --> ${action}"
                    if (action == 'apply' || action == 'destroy') {
                        input message: "Do you want to approve the ${action} ?", ok: 'Approve'
                        sh "terraform ${action} --auto-approve"
                    } else {
                        input message: "Do you want to approve the ${action} ?", ok: 'Approve'

                        withCredentials([string(credentialsId: 'aws_credentials', variable: 'secret')]) {
                        script {
                            def creds = readJSON text: secret
                            env.AWS_ACCESS_KEY_ID = creds['AWS_ACCESS_KEY_ID']
                            env.AWS_SECRET_ACCESS_KEY = creds['AWS_SECRET_ACCESS_KEY']
                                                        env.GITHUB_TOKEN = creds['GITHUB_TOKEN']

                            env.AWS_REGION = 'ap-south-1' 
                        }
                            sh "terraform ${action}"
                    }

                    }       
                }
        }
    }
}
}


