pipeline {
    agent any
    environment {
        GITHUB_TOKEN_SCERET = credentials('aws-jenkins-credentials')
        AWS_TOKEN_SCERET = credentials('aws-credentials')
        AWS_REGION = 'ap-south-1' 
    }
    tools {
        terraform 'terrafrom'
    }

    stages {
        stage('init') {
            steps {
                        echo "${GITHUB_TOKEN_SCERET}"
                        echo "${AWS_TOKEN_SCERET}"

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
                        sh "terraform ${action}"
                        echo "${GITHUB_TOKEN_SCERET}"
    }
                    }       
                }
        }
    }
}
}


