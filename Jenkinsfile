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

                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api'

                }
            }
        }

        stage('Nexus Repo-Release'){

            steps{

                script{

                    nexusArtifactUploader artifacts: [[artifactId: 'springboot', 
                    classifier: '', 
                    file: 'target/Uber.jar', 
                    type: 'jar']], 
                    credentialsId: 'Nexus', 
                    groupId: 'com.example', 
                    nexusUrl: '13.232.123.194:8081', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: 'demo-app-release', 
                    version: '1.0.0'
                }
            }
        }        
    }
}
