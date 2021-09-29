node {

    stage("Git Clone"){

        git credentialsId: 'GIT_HUB_CREDENTIALS', url: 'https://github.com/nkciam/kubernetesproject.git'
    }

    stage("Docker build"){
        sh 'docker version'
        sh 'docker build -t chung-docker-demo .'
        sh 'docker image list'
        sh 'docker tag chung-docker-demo nkciam/chungnk:chung-docker-demo'
    }

    withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWORD', variable: 'PASSWORD')]) {
        sh 'docker login -u nkciam -p $PASSWORD'
    }

    stage("Push Image to Docker Hub"){
        sh 'docker push nkciam/chungnk:chung-docker-demo'
    }
    
    stage("kubernetes deployment"){
        sh 'kubectl apply -f k8s-spring-boot-deployment.yml'
    }
} 
