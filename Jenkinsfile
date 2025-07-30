pipeline {
  agent any

  environment {
    CISCO_USER = credentials('CISCO_CREDS_USR')
    CISCO_PASS = credentials('CISCO_CREDS_PSW')
  }

  stages {
    stage('Install Chef Workstation') {
      steps {
        sh 'chmod +x install_chef.sh && ./install_chef.sh'
      }
    }

    stage('Set Cisco Banner with Chef') {
      steps {
        echo "[INFO] Running Chef Recipe..."
        sh '''
          export CISCO_USER=$CISCO_USER
          export CISCO_PASS=$CISCO_PASS
          chef-apply set_banner.rb
        '''
      }
    }
  }
}
