pipeline {
  agent any

  environment {
    CHEF_URL = 'https://omnitruck.chef.io/install.sh'
  }

  stages {
    stage('Install Chef') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'jenkins-sudo-creds', usernameVariable: 'SUDO_USER', passwordVariable: 'SUDO_PASS')]) {
          sh '''
            echo "[INFO] Downloading Chef install script..."
            wget $CHEF_URL -O install_chef.sh

            echo "[INFO] Installing Chef using sudo..."
            echo "$SUDO_PASS" | sudo -S bash install_chef.sh
          '''
        }
      }
    }

    stage('Run Chef Banner Config') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'cisco-ssh-creds', usernameVariable: 'DEVICE_USER', passwordVariable: 'DEVICE_PASS')]) {
          sh '''
            echo "[INFO] Running Chef Banner Recipe..."
            chef-client --local-mode set_banner.rb
          '''
        }
      }
    }
  }
}
