pipeline {
  agent any

  environment {
    // Used for sudo password in Chef install
    SUDO_PASS = credentials('jenkins-sudo-creds')
    // Used for SSH to Cisco devices via Chef
    CISCO_USER = credentials('cisco-ssh-creds').username
    CISCO_PASS = credentials('cisco-ssh-creds').password
  }

  stages {

    stage('Install Chef Workstation') {
      steps {
        echo "[INFO] Installing Chef Workstation with sudo..."

        // Using script block to pass password via stdin to sudo
        script {
          sh '''
            echo "$SUDO_PASS" | sudo -S bash install_chef.sh
          '''
        }
      }
    }

    stage('Run Chef Banner Config') {
      steps {
        echo "[INFO] Running Chef Recipe to configure Cisco banners..."
        sh '''
          chef-client --local-mode --runlist 'recipe[cisco_banner]'
        '''
      }
    }
  }
}
