pipeline {
 agent {
    node {
      label 'go'
    }
  }



    environment {
        REGISTRY = 'registry.cn-beijing.aliyuncs.com/pox'
        APP_NAME = 'zkevm-sequencer-batch'
    }

  stages {
       stage('check out from git') {
               steps {
                 checkout([$class: 'GitSCM',
                 branches: [[name: 'dev']],
                 extensions: [[$class: 'SubmoduleOption',
                 disableSubmodules: false,
                 parentCredentials: true,
                 recursiveSubmodules: true,
                 reference: '', trackingSubmodules: true]],
                 userRemoteConfigs: [[credentialsId: 'gitaccount', url: 'http://git.everylink.ai/crosschain/sequencer']]])
               }
       }
    stage('build & push') {
      steps {
        container('go') {
          withCredentials([usernamePassword(passwordVariable : 'DOCKER_PASSWORD' ,credentialsId : 'dockerhub' ,usernameVariable : 'DOCKER_USERNAME' ,)]) {
            sh 'echo "$DOCKER_PASSWORD" | docker login $REGISTRY -u "$DOCKER_USERNAME" --password-stdin'
            sh 'docker build -f Dockerfile -t $REGISTRY/$APP_NAME:SNAPSHOT-$BUILD_NUMBER .'
            sh 'docker push $REGISTRY/$APP_NAME:SNAPSHOT-$BUILD_NUMBER'
           }
         }
      }
    }
    stage('deploy to sandbox') {
      steps {
       container ('go') {
                                 withCredentials([
                                     kubeconfigFile(
                                     credentialsId: 'kubeconfig',
                                     variable: 'KUBECONFIG')
                                     ]) {
                                     sh 'envsubst < deploy/sandbox/node0/deployment.yaml | kubectl apply -f -'
                                     sh 'envsubst < deploy/sandbox/node0/service.yaml | kubectl apply -f -'
                                      sh 'envsubst < deploy/sandbox/node1/deployment.yaml | kubectl apply -f -'
                                      sh 'envsubst < deploy/sandbox/node1/service.yaml | kubectl apply -f -'
                                       sh 'envsubst < deploy/sandbox/node2/deployment.yaml | kubectl apply -f -'
                                       sh 'envsubst < deploy/sandbox/node2/service.yaml | kubectl apply -f -'
                                 }
                            }
      }
    }




  }
}