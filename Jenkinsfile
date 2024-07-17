pipeline {
    agent any
    tools {
  terraform 'terrafrom'
}

    stages {
        stage('init') {
            steps {
                	input message: 'Do you want to approve the init ?', ok: 'Approve'
                    sh 'terraform init -reconfigure -backend-config="bucket=bucket-for-tf-state-task-akshaya"'
            }
        }
        stage ("Action") {
            steps {   
                 script {
                    echo "Terraform action is --> ${action}"
                    if (action == 'apply' || action == 'destroy') {
                        sh "terraform ${action} --auto-approve"
                    } else {
                        sh "terraform ${action}"
                    }       
                }
        }
    }
}
}
