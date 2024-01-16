pipeline {
  agent any

  parameters {
    choice(
        choices: ['android', 'iOS'],
        description: 'Selection to OS',
        name: 'OS_TYPE_PARAM')
    choice(
        choices: ['STREAMING', 'BANKING', 'DELIVERY', 'ECOMMERCE', 'SOCIAL', 'VIDEOGAME'],
        description: 'Selection to OS',
        name: 'APP_TYPE_PARAM')
    choice(
        choices: ['manual', 'automated'],
        description: 'Selection to make tests',
        name: 'TEST_TYPE_PARAM')
    string (
        defaultValue: '2',
        description: '',
        name: 'TEST_TIME_PARAM')
    string (
        defaultValue: 'false',
        description: '',
        name: 'STRICT_MODE_PARAM')
    string (
        defaultValue: '',
        description: '',
        name: 'PACKAGE_ID_PARAM')

  }

  stages {

    stage ('Build') {
        steps {
          sh '''
            set
            echo "********************************************************"
            echo "*                                                      *"
            echo "*   🚀 Iniciando el proceso de construcción 🚀          *"
            echo "*                                                      *"
            echo "********************************************************"
            ${WORKSPACE}/gradlew build
          '''
      }

    }

    stage ('Test') {
        steps {
          sh '''
            set
            echo "********************************************************"
            echo "*                                                      *"
            echo "*          🧪 Iniciando las pruebas 🧪                  *"
            echo "*                                                      *"
            echo "********************************************************"
            ${WORKSPACE}/gradlew build
          '''
          script {
              compileAndroid = sh (script: 'bash ${WORKSPACE}/scripts/tests.sh ${PACKAGE_ID_PARAM} ${OS_TYPE_PARAM} ${TEST_TYPE_PARAM} ${TEST_TIME_PARAM} ${STRICT_MODE_PARAM} ${APP_TYPE_PARAM}')
          }
      }
    }

    stage('Analize battery stats') {
      steps {
        sh '''
          set
          echo "**********************************************************"
          echo "*                                                        *"
          echo "*   🔋 Iniciando el análisis del consumo de batería 🔋    *"
          echo "*                                                        *"
          echo "**********************************************************"
          sleep 10
          apt install python3 -y
        '''

        script {
              buildFile = sh (script: 'python3 ${WORKSPACE}/scripts/readit.py ${WORKSPACE} ${OS_TYPE_PARAM} ${TEST_TYPE_PARAM} ${TEST_TIME_PARAM} ${STRICT_MODE_PARAM} ${APP_TYPE_PARAM}')
        }
      }
    }

  }
}