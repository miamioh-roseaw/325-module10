pipeline {
  agent any

  environment {
    SSH_CREDS = credentials('cisco-ssh-creds')
    SUDO_PASS = credentials('jenkins-sudo-creds')
  }

  stages {
    stage('Install Chef') {
      steps {
        echo "[INFO] Installing Chef using sudo..."
        sh '''
          echo "$SUDO_PASS_PSW" | sudo -S bash install_chef.sh
        '''
      }
    }

    stage('Run Chef Banner Config') {
      steps {
        sh '''
          chef-client --local-mode banner_recipe.rb
        '''
      }
    }
  }
}
