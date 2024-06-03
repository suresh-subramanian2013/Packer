pipeline {
    agent any 
    stages {
        stage ("Packer ami"){
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credential', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh 'packer init .'
			sh 'packer build aws.ami.v1.pkr.hcl'
    }
            }
        }
}
}