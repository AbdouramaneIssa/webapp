pipeline {
    agent any
    
    // Configuration des paramètres Slack
    // Le nom de la configuration Slack est "Jenkins-Notifier" comme spécifié par l'utilisateur.
    // Le canal est "#jenkins-builds".
    def slackChannel = '#jenkins-builds'
    def slackConfig = 'Jenkins-Notifier'
    
    // Définition des options globales pour le pipeline
    options {
        // Option pour nettoyer l'espace de travail après l'exécution
        skipDefaultCheckout()
        // Définir le fuseau horaire pour les logs
        timestamps()
    }

    // Déclencheur : Le pipeline sera déclenché par un push sur la branche 'dev'
    // Note: Le déclenchement réel est géré par le webhook GitHub configuré dans Jenkins.
    // Ce bloc est plus pour la documentation et les bonnes pratiques.
    // Pour un pipeline de type "Multibranch Pipeline" ou "Organization Folder", Jenkins gère cela automatiquement.
    // Pour un pipeline de type "Pipeline" simple, le webhook doit être configuré pour pointer vers l'URL de Jenkins et le job.
    // Le bloc 'triggers' n'est pas strictement nécessaire pour le SCM polling ou les webhooks.
    
    stages {
        stage('Démarrage du Pipeline') {
            steps {
                script {
                    // Notification de début de build
                    slackSend(
                        channel: slackChannel,
                        color: 'good',
                        message: "✅ *Démarrage du Pipeline* : Le build #${env.BUILD_NUMBER} pour le dépôt `${env.JOB_NAME}` sur la branche `${env.BRANCH_NAME}` a commencé. (<${env.BUILD_URL}|Voir le Build>)",
                        teamDomain: 'travailraman',
                        tokenCredentialId: slackConfig
                    )
                }
            }
        }
        
        stage('Checkout du Code') {
            steps {
                // Récupération du code depuis GitHub
                checkout scm
                script {
                    // Notification de succès de l'étape
                    slackSend(
                        channel: slackChannel,
                        color: 'good',
                        message: "ℹ️ *Étape 1/4: Checkout du Code* : Code récupéré avec succès sur la branche `${env.BRANCH_NAME}`. (<${env.BUILD_URL}|Détails>)",
                        teamDomain: 'travailraman',
                        tokenCredentialId: slackConfig
                    )
                }
            }
        }

        stage('Build') {
            steps {
                echo 'Simuler l\'étape de construction (par exemple, npm install, mvn package, docker build)'
                // Remplacer ceci par vos commandes de build réelles
                // sh 'npm install'
                // sh 'npm run build'
                script {
                    // Notification de succès de l'étape
                    slackSend(
                        channel: slackChannel,
                        color: 'good',
                        message: "🛠️ *Étape 2/4: Build* : La construction du projet est terminée. (<${env.BUILD_URL}|Détails>)",
                        teamDomain: 'travailraman',
                        tokenCredentialId: slackConfig
                    )
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Simuler l\'étape de test (par exemple, npm test, mvn test)'
                // Remplacer ceci par vos commandes de test réelles
                // sh 'npm test'
                script {
                    // Notification de succès de l'étape
                    slackSend(
                        channel: slackChannel,
                        color: 'good',
                        message: "🧪 *Étape 3/4: Test* : Les tests unitaires et d'intégration ont réussi. (<${env.BUILD_URL}|Détails>)",
                        teamDomain: 'travailraman',
                        tokenCredentialId: slackConfig
                    )
                }
            }
        }

        stage('Déploiement') {
            steps {
                echo 'Simuler l\'étape de déploiement sur l\'environnement DEV'
                // Remplacer ceci par vos commandes de déploiement réelles
                // sh 'ssh user@dev-server "deploy-script.sh"'
                script {
                    // Notification de succès de l'étape
                    slackSend(
                        channel: slackChannel,
                        color: 'good',
                        message: "🚀 *Étape 4/4: Déploiement* : Le déploiement sur l'environnement DEV est terminé. (<${env.BUILD_URL}|Détails>)",
                        teamDomain: 'travailraman',
                        tokenCredentialId: slackConfig
                    )
                }
            }
        }
    }
    
    // Post-actions : Exécutées après toutes les étapes, quel que soit le résultat
    post {
        always {
            // Nettoyage de l'espace de travail
            cleanWs()
        }
        success {
            script {
                // Notification de succès final
                slackSend(
                    channel: slackChannel,
                    color: 'good',
                    message: "🎉 *Pipeline SUCCÈS* : Le build #${env.BUILD_NUMBER} pour `${env.JOB_NAME}` est terminé avec succès. Déploiement sur DEV réussi. (<${env.BUILD_URL}|Voir le Build>)",
                    teamDomain: 'travailraman',
                    tokenCredentialId: slackConfig
                )
            }
        }
        failure {
            script {
                // Notification d'échec
                slackSend(
                    channel: slackChannel,
                    color: 'danger',
                    message: "❌ *Pipeline ÉCHEC* : Le build #${env.BUILD_NUMBER} pour `${env.JOB_NAME}` a échoué. Vérifiez les logs. (<${env.BUILD_URL}|Voir le Build>)",
                    teamDomain: 'travailraman',
                    tokenCredentialId: slackConfig
                )
            }
        }
    }
}
