pipeline {
  agent any

  environment {
    CHEF_REPO = '.'  // Flat structure
    CISCO_CREDS = credentials('cisco-ssh-creds')
    PATH = "${HOME}/.local/bin:${env.PATH}"
  }

  stages {

    stage('Install Dependencies') {
      steps {
        sh '''
          # Ensure sshpass is installed
          if ! command -v sshpass > /dev/null; then
            echo "[INFO] Installing sshpass..."
            sudo apt-get update && sudo apt-get install -y sshpass
          fi

          # Install Chef if needed
          if ! command -v chef-client > /dev/null; then
            echo "[INFO] Installing Chef..."
            curl -L https://omnitruck.chef.io/install.sh | sudo bash
          else
            echo "[INFO] Chef already installed."
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
