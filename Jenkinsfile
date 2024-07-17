// pipeline {
//     agent any
//     environment {
//         GITHUB_TOKEN_SCERET = credentials('aws-jenkins-credentials')
//         AWS_TOKEN_SCERET = credentials('aws-credentials')
//         AWS_REGION = 'ap-south-1' 
//     }
//     tools {
//         terraform 'terrafrom'
//     }

//     stages {
//         stage('Retrieve AWS Credentials') {
//             steps {
//                 script {
//                     def secrets = sh(script: "aws secretsmanager get-secret-value --secret-id ${env.AWS_TOKEN_SCERET} --region ${env.AWS_REGION} --query SecretString --output text", returnStdout: true).trim()
//                     def json = readJSON text: secrets
//                     env.AWS_ACCESS_KEY_ID = json.AWS_ACCESS_KEY_ID
//                     env.AWS_SECRET_ACCESS_KEY = json.AWS_SECRET_ACCESS_KEY
//                      sh 'echo "AWS Access Key ID: ${AWS_ACCESS_KEY_ID}"'
//                     sh 'echo "AWS Secret Access Key: ${AWS_SECRET_ACCESS_KEY}"'

//                     def secrets_git = sh(script: "aws secretsmanager get-secret-value --secret-id ${env.GITHUB_TOKEN_SCERET} --region ${env.AWS_REGION} --query SecretString --output text", returnStdout: true).trim()
//                     def json_git = readJSON text: secrets
//                     env.GITHUB_TOKEN = json.GITHUB_TOKEN
//                     sh 'echo "AWS Secret Access Key: ${GITHUB_TOKEN}"'

//                 }
//             }
//         }
//         stage('init') {
//             steps {
//                     sh 'terraform init -reconfigure -backend-config="bucket=bucket-for-tf-state-task-akshaya"'
//             }
//         }
//         stage ("Action") {
//             steps {   
//                  script {
//                     echo "Terraform action is --> ${action}"
//                     if (action == 'apply' || action == 'destroy') {
//                         input message: "Do you want to approve the ${action} ?", ok: 'Approve'
//                         sh "terraform ${action} --auto-approve"
//                     } else {
//                         input message: "Do you want to approve the ${action} ?", ok: 'Approve'
//                         sh "terraform ${action}"
//                     }       
//                 }
//         }
//     }
// }
// }

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
        stage('Retrieve AWS Credentials') {
            steps {
                script {
                    def awsSecrets = sh(script: "aws secretsmanager get-secret-value --secret-id ${AWS_TOKEN_SCERET} --region ${AWS_REGION} --query SecretString --output text", returnStdout: true).trim()
                    def awsJson = readJSON text: awsSecrets
                    env.AWS_ACCESS_KEY_ID = awsJson.AWS_ACCESS_KEY_ID
                    env.AWS_SECRET_ACCESS_KEY = awsJson.AWS_SECRET_ACCESS_KEY

                    echo 'AWS Access Key ID retrieved'
                    // echo "AWS Secret Access Key: ${AWS_SECRET_ACCESS_KEY}"  // Do not echo sensitive information

                    def gitSecrets = sh(script: "aws secretsmanager get-secret-value --secret-id ${GITHUB_TOKEN_SCERET} --region ${AWS_REGION} --query SecretString --output text", returnStdout: true).trim()
                    def gitJson = readJSON text: gitSecrets
                    env.GITHUB_TOKEN = gitJson.GITHUB_TOKEN

                    echo 'GitHub token retrieved'
                }
            }
        }
        stage('init') {
            steps {
                withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'terraform init -reconfigure -backend-config="bucket=bucket-for-tf-state-task-akshaya"'
                }
            }
        }
        stage ("Action") {
            steps {   
                script {
                    echo "Terraform action is --> ${action}"
                    if (action == 'apply' || action == 'destroy') {
                        input message: "Do you want to approve the ${action}?", ok: 'Approve'

                        withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh "terraform ${action} --auto-approve"
                }

                    } else {
                        input message: "Do you want to approve the ${action}?", ok: 'Approve'

                        withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh "terraform ${action}"
                }
                    }       
                }
            }
        }
    }
}
