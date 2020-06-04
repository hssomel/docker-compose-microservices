pipeline{
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: docker
    image: gurkamal/docker-in-docker:18.09.9
    imagePullPolicy: Always
    command:
    - cat
    tty: true
    volumeMounts:
    - mountPath: /var/run/docker.sock
      name: docker-sock
  volumes:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock
"""
    }
  }
  environment {
    ME_CONFIG_BASICAUTH_USERNAME = credentials('ME_CONFIG_BASICAUTH_USERNAME')
    ME_CONFIG_BASICAUTH_PASSWORD = credentials('ME_CONFIG_BASICAUTH_PASSWORD')
    MONGO_ROOT_USERNAME = credentials('MONGO_ROOT_USERNAME')
    MONGO_ROOT_PASSWORD = credentials('MONGO_ROOT_PASSWORD')

    DOCKERHUB_USERNAME = credentials('dockerhub-username')
    DOCKERHUB_PASSWORD = credentials('dockerhub-password')
  }
  stages {
    stage('Download Repo') {
      steps {
        container('docker') {
          git credentialsId: '964b7f10-4c8b-425f-8b37-67ad7e96beae', url: 'https://git.toptal.com/screening/gurkamal-singh'
        }
      }
    }
    stage('Log into Dockerhub') {
      steps {
        container('docker') {
          sh "docker login --username=\$DOCKERHUB_USERNAME --password=\$DOCKERHUB_PASSWORD"
        }
      }
    }
    stage('Build & Publish Images to DockerHub') {
      steps {
        container('docker') {
          sh "docker build static -t gurkamal/static:${BUILD_NUMBER}-dev"
          sh "docker build haproxy -t gurkamal/haproxy:${BUILD_NUMBER}-dev"
          sh "docker build statistics -t gurkamal/statistics:${BUILD_NUMBER}-dev"
          sh "docker tag gurkamal/static:${BUILD_NUMBER}-dev gurkamal/static:latest"
          sh "docker tag gurkamal/haproxy:${BUILD_NUMBER}-dev gurkamal/haproxy:latest"
          sh "docker tag gurkamal/statistics:${BUILD_NUMBER}-dev gurkamal/statistics:latest"
          sh "docker push gurkamal/static:${BUILD_NUMBER}-dev"
          sh "docker push gurkamal/haproxy:${BUILD_NUMBER}-dev"
          sh "docker push gurkamal/statistics:${BUILD_NUMBER}-dev"
          sh "docker push gurkamal/static:latest"
          sh "docker push gurkamal/haproxy:latest"
          sh "docker push gurkamal/statistics:latest"
        }
      }
    }
    stage('Reset previous dev environment') {
      steps {
        container('docker') {
          sh 'export RESULT=\$(kubectl get namespaces | grep "^dev ")'
          sh 'if [ -z "\$RESULT" ]; then kubectl delete namespace dev; fi'
          sh "kubectl create ns dev"
        }
      }
    } 
    stage('Expose dev environment at dev.gurkamalsingh.com') {
      steps {
        container('docker') {
          sh """echo '
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: dev
  generation: 1
  namespace: dev
spec:
  rules:
  - host: dev.gurkamalsingh.com
    http:
      paths:
      - backend:
          serviceName: haproxy
          servicePort: 80' > ingress.yaml
"""
          sh "kubectl apply -f ingress.yaml"
        }
      }
    }   
    stage('Deploy to Kubernetes') {
      steps {
        container('docker') {
          sh 'envsubst < docker-compose.yml > rendered-docker-compose.yml'
          sh "kompose convert --file rendered-docker-compose.yml --out dev-manifest.yaml"
          sh "kubectl apply -f dev-manifest.yaml -n dev"
        }
      }
    }   
  }
}