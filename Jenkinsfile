pipeline {
    agent any
    
    // CORRECTION : Les variables d'environnement doivent être déclarées ici
    environment {
        SLACK_CHANNEL = '#jenkins-builds'
        SLACK_CONFIG = 'Jenkins-Notifier' // Le nom de l'API/Credential ID
        SLACK_DOMAIN = 'travailraman' // Le nom du domaine/workspace Slack
    }
    
    // Définition des options globales pour le pipeline
    options {
        // Option pour nettoyer l'espace de travail après l'exécution
        skipDefaultCheckout()
        // Définir le fuseau horaire pour les logs
        timestamps()
    }

    stages {
        stage('Démarrage du Pipeline') {
            steps {
                // Notification de début de build (plus besoin du bloc 'script' pour la notification ici)
                slackSend(
                    channel: env.SLACK_CHANNEL,
                    color: '#ffc107', // Jaune/Orange pour le démarrage
                    message: "✅ *Démarrage du Pipeline* : Le build #${env.BUILD_NUMBER} pour le dépôt `${env.JOB_NAME}` sur la branche `${env.BRANCH_NAME}` a commencé. (<${env.BUILD_URL}|Voir le Build>)",
                    teamDomain: env.SLACK_DOMAIN,
                    tokenCredentialId: env.SLACK_CONFIG
                )
            }
        }
        
        stage('Checkout du Code') {
            steps {
                // Récupération du code depuis GitHub
                checkout scm
                // Notification de succès de l'étape
                slackSend(
                    channel: env.SLACK_CHANNEL,
                    color: 'good',
                    message: "ℹ️ *Étape 1/4: Checkout du Code* : Code récupéré avec succès sur la branche `${env.BRANCH_NAME}`. (<${env.BUILD_URL}|Détails>)",
                    teamDomain: env.SLACK_DOMAIN,
                    tokenCredentialId: env.SLACK_CONFIG
                )
            }
        }

        stage('Build') {
            steps {
                echo 'Simuler l\'étape de construction (par exemple, npm install, mvn package, docker build)'
                // sh 'npm install' // Décommenter pour une vraie commande
                slackSend(
                    channel: env.SLACK_CHANNEL,
                    color: 'good',
                    message: "🛠️ *Étape 2/4: Build* : La construction du projet est terminée. (<${env.BUILD_URL}|Détails>)",
                    teamDomain: env.SLACK_DOMAIN,
                    tokenCredentialId: env.SLACK_CONFIG
                )
            }
        }

        stage('Test') {
            steps {
                echo 'Simuler l\'étape de test (par exemple, npm test, mvn test)'
                // sh 'npm test' // Décommenter pour une vraie commande
                slackSend(
                    channel: env.SLACK_CHANNEL,
                    color: 'good',
                    message: "🧪 *Étape 3/4: Test* : Les tests unitaires et d'intégration ont réussi. (<${env.BUILD_URL}|Détails>)",
                    teamDomain: env.SLACK_DOMAIN,
                    tokenCredentialId: env.SLACK_CONFIG
                )
            }
        }

        stage('Déploiement') {
            steps {
                echo 'Simuler l\'étape de déploiement sur l\'environnement DEV'
                // sh 'ssh user@dev-server "deploy-script.sh"' // Décommenter pour une vraie commande
                slackSend(
                    channel: env.SLACK_CHANNEL,
                    color: 'good',
                    message: "🚀 *Étape 4/4: Déploiement* : Le déploiement sur l'environnement DEV est terminé. (<${env.BUILD_URL}|Détails>)",
                    teamDomain: env.SLACK_DOMAIN,
                    tokenCredentialId: env.SLACK_CONFIG
                )
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
            // Notification de succès final
            slackSend(
                channel: env.SLACK_CHANNEL,
                color: 'good',
                message: "🎉 *Pipeline SUCCÈS* : Le build #${env.BUILD_NUMBER} pour `${env.JOB_NAME}` est terminé avec succès. Déploiement sur DEV réussi. (<${env.BUILD_URL}|Voir le Build>)",
                teamDomain: env.SLACK_DOMAIN,
                tokenCredentialId: env.SLACK_CONFIG
            )
        }
        failure {
            // Notification d'échec
            slackSend(
                channel: env.SLACK_CHANNEL,
                color: 'danger',
                message: "❌ *Pipeline ÉCHEC* : Le build #${env.BUILD_NUMBER} pour `${env.JOB_NAME}` a échoué. Vérifiez les logs. (<${env.BUILD_URL}|Voir le Build>)",
                teamDomain: env.SLACK_DOMAIN,
                tokenCredentialId: env.SLACK_CONFIG
            )
        }
    }
}