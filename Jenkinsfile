pipeline {
    agent any
    tools {
        terraform 'terraform'

    environment {
        AWS_ACCESS_KEY_ID = credentials("AWS_ACCESS_KEY_ID_cred")
        AWS_SECRET_ACCESS_KEY = credentials("AWS_SECRET_ACCESS_KEY_cred")
        GITHUB_TOKEN = credentials("GITHUB_cred")
        AWS_REGION = 'ap-south-1'
    }

    stages {
        stage('init') {
            steps {
                sh 'terraform init -reconfigure -backend-config="bucket=bucket-for-tf-state-task-akshaya"'
            }
        }
        stage('Action') {
            steps {
                script {
                    echo "Terraform action is --> ${action}"
                    if (action == 'apply' || action == 'destroy') {
                        input message: "Do you want to approve the ${action}?", ok: 'Approve'
                        sh "terraform ${action} --auto-approve"
                    } else {
                        input message: "Do you want to approve the ${action}?", ok: 'Approve'
                        sh "terraform ${action}"
                    }
                }
            }
        }
    }
}
