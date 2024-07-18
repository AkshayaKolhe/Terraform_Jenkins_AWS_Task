// pipeline {
//     agent any
//     // tools {
//     //     terraform 'terrafrom'
//     // }

//     // environment {
//     //     AWS_ACCESS_KEY_ID = credentials("AWS_ACCESS_KEY_ID_cred")
//     //     AWS_SECRET_ACCESS_KEY = credentials("AWS_SECRET_ACCESS_KEY_cred")
//     //     GITHUB_TOKEN = credentials("GITHUB_cred")
//     //     AWS_REGION = 'ap-south-1'
//     // }
//     parameters {
//         choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Choose the Terraform action to perform')
//     }


//     stages {
//         stage('init') {
//             steps {
//                 sh 'terraform init -reconfigure -backend-config="bucket=bucket-for-tf-state-task-akshaya"'
//             }
//         }
//         stage('Action') {
//             steps {
//                 script {
//                     def action = params.ACTION ?: 'plan'
//                     echo "Terraform action is --> ${action}"
//                     if (action == 'apply' || action == 'destroy') {
//                         input message: "Do you want to approve the ${action}?", ok: 'Approve'
//                         sh "terraform ${action} --auto-approve"
//                     } else {
//                         input message: "Do you want to approve the ${action}?", ok: 'Approve'
//                         sh "terraform ${action}"
//                     }
//                 }
//             }
//         }
//     }
// }

pipeline {
    agent any

    stages {

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

