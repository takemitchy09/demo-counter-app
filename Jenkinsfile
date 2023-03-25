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

        stage('Nexus Release'){

          steps{
            
            script{
                def readPomVersion = readMavenPom file : 'pom.xml'
                def nexusRepo = readPomVersion.version.endsWith ("SNAPSHOT") ? "demo-app-SNAPSHOT" : "demo-app-release"
                nexusArtifactUploader artifacts: 
                [
                    [
                        artifactId: 'springboot', 
                        classifier: '', 
                        file: 'target/Uber.jar', 
                        type: 'jar'
                        ]
                        ], 
                        credentialsId: 'nexus-cred', 
                        groupId: 'com.example', 
                        nexusUrl: '18.140.246.75:8081', 
                        nexusVersion: 'nexus3', 
                        protocol: 'http', 
                        repository: nexusRepo, 
                        version: "${readPomVersion.version}"
            }
          }

        }        
      } 
}