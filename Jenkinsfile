pipeline{
    agent any

      stages{

        stage('Git Integration'){

          steps{

            git branch: 'main', url: 'https://github.com/takemitchy09/demo-counter-app.git'

          }

        }

        stage('Maven Unit Test'){

          steps{

            sh 'mvn test'

          }

        }

        stage('Maven Integration Test'){

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
                withSonarQubeEnv(credentialsId: 'sonar-api') {
                sh 'mvn clean package sonar:sonar'

      }
            }

          }

        }      

        stage('Quality test'){

          steps{

            script{
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api'

      }
            }

        }          
      } 
}