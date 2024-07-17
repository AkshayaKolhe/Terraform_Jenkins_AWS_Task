pipeline {
    agent any
    environment {
 AWS_ACCESS_KEY_ID = ''
        AWS_SECRET_ACCESS_KEY = ''
        GITHUB_TOKEN = ''        AWS_REGION = 'ap-south-1' 
    }
    tools {
        terraform 'terrafrom'
    }

    stages {
        stage('Retrieve Secrets') {
            steps {
                script {
                    // Retrieve secrets from AWS Secrets Manager and set them as environment variables
                    def awsAccessKeyId = sh(script: "aws secretsmanager get-secret-value --secret-id YOUR_SECRET_ID --query 'SecretString' --output text | jq -r '.AWS_ACCESS_KEY_ID'", returnStdout: true).trim()
                    def awsSecretAccessKey = sh(script: "aws secretsmanager get-secret-value --secret-id YOUR_SECRET_ID --query 'SecretString' --output text | jq -r '.AWS_SECRET_ACCESS_KEY'", returnStdout: true).trim()
                    def githubToken = sh(script: "aws secretsmanager get-secret-value --secret-id YOUR_SECRET_ID --query 'SecretString' --output text | jq -r '.GITHUB_TOKEN'", returnStdout: true).trim()

                    // Set environment variables
                    env.AWS_ACCESS_KEY_ID = awsAccessKeyId
                    env.AWS_SECRET_ACCESS_KEY = awsSecretAccessKey
                    env.GITHUB_TOKEN = githubToken
                }
            }
        }
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
                        withCredentials([usernamePassword(credentialsId: 'aws-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),string(credentialsId: 'GITHUB_TOKEN', variable: 'GITHUB_TOKEN')]) {
                            sh "terraform ${action}"
                        }    }
                    }       
                }
        }
    }
}
}


