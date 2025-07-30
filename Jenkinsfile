pipeline {
  agent any

  environment {
    SUDO_PASS = credentials('jenkins-sudo-creds')
  }

  stages {
    stage('Install Chef Workstation') {
      steps {
        echo "[INFO] Installing Chef Workstation with sudo..."

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

        withCredentials([usernamePassword(credentialsId: 'cisco-ssh-creds', usernameVariable: 'CISCO_USER', passwordVariable: 'CISCO_PASS')]) {
          sh '''
            echo "[INFO] Using SSH credentials for Cisco devices..."
            chef-client --local-mode --runlist 'recipe[cisco_banner]'
          '''
        }
      }
    }
  }
}
