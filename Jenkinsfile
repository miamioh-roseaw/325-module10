pipeline {
  agent any

  environment {
    CHEF_URL = 'https://omnitruck.chef.io/install.sh'
  }

  stages {
    stage('Install Chef') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'cisco-ssh-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
          sh '''
            echo "[INFO] Downloading Chef install script..."
            wget $CHEF_URL -O install_chef.sh

            echo "[INFO] Installing Chef..."
            echo "$PASS" | sudo -S bash install_chef.sh
          '''
        }
      }
    }

    stage('Run Chef Banner Config') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'cisco-ssh-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
          sh '''
            echo "[INFO] Running Chef..."
            chef-client --local-mode set_banner.rb
          '''
        }
      }
    }
  }
}
