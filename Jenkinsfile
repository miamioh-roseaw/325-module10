pipeline {
  agent any

  environment {
    SUDO_PASS = credentials('jenkins-sudo-creds')
  }

  stages {
    stage('Install and Run Chef Solo') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'jenkins-sudo-creds', passwordVariable: 'SUDO_PASS', usernameVariable: 'SUDO_USER')]) {
          sh '''
            echo "[INFO] Installing Chef Solo..."
            echo "$SUDO_PASS" | sudo -S bash install_chef_solo.sh

            echo "[INFO] Running Chef Solo..."
            sudo chef-solo -c solo.rb -o 'banner_cookbook'
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
