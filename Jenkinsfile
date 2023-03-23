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
    }
}