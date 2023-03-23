pipeline {
    
    agent any

    stages{

        stage('Git Checkout'){

            steps{
                git branch: 'main', url: 'https://github.com/takemitchy09/demo-counter-app.git'
            }
        }
        
        stage('Maven UNIT test'){

            steps{
                sh 'mvn test'
            }
        }

        stage('Maven Integration test'){

            steps{
                sh 'mvn verify -DskipUnitTests'
            }
        }      
       
       stage('Maven Build'){

            steps{
                sh 'mvn clean install'
            }
        }

       stage('Static Code Analysis'){

            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                    sh 'mvn clean package sonar:sonar'
        }
                }
            }
        }     
       stage('Quality Gate Status'){

            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                }
            }
        }    
    }
}
