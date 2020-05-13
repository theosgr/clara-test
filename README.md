# Autoriser un développeur à déployer

## Générer une clef publique sur le poste du développeur
`ssh-keygen -trsa -b4096`

## Copier la clef générée sur la machine de production ou la machine de recette
dans le fichier `/home/livraison/.ssh/authorized_keys`

# Déploiement

## Sur la recette
Sur son poste, aller dans le répertoire private puis:
`private$> ./deploy.sh recette`

... et suivre les instructions.

## Sur la production
Sur son poste, aller dans le répertoire private puis:
`private$> ./deploy.sh production`

... et suivre les instructions.


# Redémarrage

## Sur la recette
Sur son poste, aller dans le répertoire private puis:
`private$> ./restart.sh recette`

... et suivre les instructions.

## Sur la production
Sur son poste, aller dans le répertoire private puis:
`private$> ./restart.sh production`

... et suivre les instructions.

# Mettre à jour la base de données

## Sur la recette
Sur son poste, aller dans le répertoire private puis:
`private$> ./majbd.sh recette`

... et suivre les instructions.

## Sur la production
Sur son poste, aller dans le répertoire private puis:
`private$> ./majbd.sh production`

... et suivre les instructions.
