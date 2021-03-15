pipeline {
    agent any
    tools {
       maven 'mvn'   
    }
    stages {
        stage('build') {
            steps {
                //sh 'mvn --version'
                sh 'mvn clean'
                echo 'hello build'
                sh 'mvn validate'
                sh 'mvn compile -X'
            }
        }
        stage('test') {
            steps {
               
                echo 'hello test'
                sh 'mvn test'
                
            }
        }
         stage('package') {
            steps {
               
                echo 'hello package'
                sh 'mvn package'
                
            }
        }
        stage('docker image') {
            steps {
                sh 'mv /var/lib/jenkins/workspace/jd-ticketing/target/SpringMVC-ProjectManagement-0.0.1-SNAPSHOT.jar /var/lib/jenkins/workspace/jd-ticketing/jd-ticketing.jar'
                sh ' ls -la'
                echo 'hello docker'
                sh 'echo $(pwd)'
                //sh ' docker version'
                sh ' docker build --tag=jd-ticketing:latest . '
                script {
                 try {
                        sh '''
                        docker-compose down
                        #docker rmi -f $(docker images | grep "jd-ticketing" | awk "{print \$3}")

                        '''
                    } catch (err) {
                        echo err.getMessage()
                        echo "Error detected, but we will continue."
                    }
                }
                sh 'docker tag jd-ticketing:latest cicdpocjenkins/cybertekrepo:jd-ticketing'
                
            }
        }
        
        stage('docker push'){
            steps {
             sh 'docker login --password=cybertek1234* --username=cicdpocjenkins'   
             sh 'docker image push cicdpocjenkins/cybertekrepo:jd-ticketing'   
            }
        }
        stage ('Clean'){
            steps {
                sh 'docker-compose down'
                //
               // sh 'docker rm jd-ticketing_jd-ticketing_1'
               // sh 'docker rm jd-ticketing_db_1'
                sh 'sleep 10'
                sh 'docker volume rm -f jd-ticketing_database-data'
                sh 'sleep 10'
            }
        }
        stage('Deploy'){
            steps {
             sh 'docker-compose up -d'    
            }
        }

        stage('Init DB'){
            steps {
                sh '''
                    echo "hello"
                    docker cp ./src/main/resources/data.sql jd-ticketing_db_1:/data.sql
                    docker exec -u postgres jd-ticketing_db_1 psql cybertek postgres -f /data.sql
                '''
            }
        }
        
        // stage('AWS Cloud deploy'){
        //     steps {
        //         script{
        //         withAWS(credentials:'awscloud', region:'eu-north-1') {
        //               sh 'aws s3 ls'
        //           }
        //       }
                
        //     }
        // }
    }
}
