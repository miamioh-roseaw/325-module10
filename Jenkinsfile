pipeline {
  agent any

  environment {
    CHEF_REPO = '.'  // Flat directory structure
    CISCO_CREDS = credentials('cisco-ssh-creds')
    PATH = "${HOME}/.local/bin:${env.PATH}"
  }

  stages {

    stage('Install Dependencies') {
      steps {
        sh '''
          echo "[INFO] Installing dependencies..."

          # Install sshpass if not available
          if ! command -v sshpass > /dev/null; then
            echo "[INFO] sshpass not found. Installing..."
            sudo apt-get update && sudo apt-get install -y sshpass
          fi

          # Install wget if not available
          if ! command -v wget > /dev/null; then
            echo "[INFO] wget not found. Installing..."
            sudo apt-get install -y wget
          fi

          # Install Chef Client using wget instead of curl
          if ! command -v chef-client > /dev/null; then
            echo "[INFO] Chef not found. Installing via wget..."
            wget https://omnitruck.chef.io/install.sh -O install_chef.sh
            sudo bash install_chef.sh
          else
            echo "[INFO] Chef is already installed."
          fi
        '''
      }
    }

    stage('Run Chef Banner Config') {
      steps {
        dir("${CHEF_REPO}") {
          sh '''
            echo "[INFO] Running Chef recipe..."

            export CISCO_CREDS_USR="${CISCO_CREDS_USR}"
            export CISCO_CREDS_PSW="${CISCO_CREDS_PSW}"

            chef-apply recipes/default.rb
          '''
        }
      }
    }
  }

  post {
    always {
      echo "[INFO] Pipeline completed"
    }
  }
}
