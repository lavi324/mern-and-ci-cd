pipeline {
    agent {
        kubernetes {
            inheritFrom 'docker-image-build'
            idleMinutes 5
            yamlFile 'Build-pod.yaml'
            defaultContainer 'dind'
        }
    }

    tools {
        nodejs "new"
    }

    environment {
        DOCKER_REGISTRY = 'https://registry.hub.docker.com'
        DOCKER_HUB_CREDENTIALS = credentials('dockerhublavi')
        TAG = '0.8'
    }

    stages {
        stage('Increment Versions') {
            steps {
                sh 'pwd'
                sh 'chmod +x increment_versions.sh'
                sh './increment_versions.sh'
            }
        }
        stage('Push to GitHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github', usernameVariable: 'GITHUB_USER', passwordVariable: 'GITHUB_PASS')]) {
                    sh '''
                    git config --global user.email "lavialduby@gmail.com"
                    git config --global user.name "lavi324"
                    '''
                    sh 'git config --global --add safe.directory /home/jenkins/agent/workspace/first'
                    sh 'git checkout main'
                    sh '''        
                    git add .
                    git commit -m "pipeline commit"
                    git push https://${GITHUB_USER}:${GITHUB_PASS}@github.com/lavi324/mern-and-ci-cd main
                    '''
                }
            }
        }
        stage('Build') {
            steps {
                dir('frontend') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }
        stage('Test Docker') {
            steps {
                script {
                    sh 'docker --version'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                dir('frontend') {
                    echo 'start build docker image'
                    sh "docker build -t lavi324/frontend:${TAG} ."
                }   
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhublavi', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push lavi324/frontend:${TAG}
                    '''
                }
            }
        }
        stage('Helm Package') {
            steps {
                sh 'helm package my-frontend-chart'
            }
        }
        stage('Helm Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhublavi', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin  
                    helm push my-frontend-chart-0.1.6.tgz oci://registry-1.docker.io/lavi324
                    '''
                }   
            }
        }
    }
    post {
        success {
            echo 'the pipeline was successfull.'
        }
    }
}
