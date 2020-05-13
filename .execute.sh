#!/bin/bash

atexit() {
	echo -en "\x1b[0m";
	echo "";
}

usage() {
	echo "Usage:";
	echo "$0 <deploy|restart|majbd> <recette|production> [options...]";
	echo " deploy: deploy the current branch master";
	echo " restart [--form-scratch]: restart app";
	echo " majbd: update database rules with latest DB";
	echo " majnginx: pull on private/ and try to restart nginx";
	echo -e "\nOption for restart:";
	echo "  --from-scratch : erase volumes and restart containers from scratch "
}

#Test si 2 paramètres sont fournis à l'execution
if [ $# -lt 2 ];
then
	usage;
	exit 1;
fi

trap atexit EXIT;

ACTION=$1;
NAME=$2;
IP="";
CMD="";

case $NAME in
	recette)
		IP="192.168.4.122";
	;;
	production)
		IP="clara.pole-emploi.fr";
	;;
	*)
		usage;
		exit 1;
	;;
esac

case $ACTION in
	deploy)
		CMD="cd /home/docker/private/; git pull; cd /home/docker/clara; docker-compose exec clara_rails bash -c \"cd clara/rails; git pull && bundle install && bundle exec mina production2 setup && bundle exec mina production2 deploy\" && service nginx configtest && service nginx reload";
		MSG="Deploying to $NAME...";
	;;
	restart)
		MSG="Restarting docker on $NAME...";
		CMD="cd /home/docker/clara;";
		TODO="restart;"
		if [ $# -eq 3 ] && [ "$3" = "--from-scratch" ];
		then
			MSG="$MSG from scratch !";
			CMD="$CMD docker-compose down -v;";
			TODO="up -d --build";
		fi
		CMD="$CMD docker-compose $TODO"
	;;
	majnginx)
		CMD="cd /home/docker/private/nginx/$NAME/; git fetch; git checkout origin/master -- ./; cd /home/docker/clara/; docker-compose exec clara_nginx bash -c \"service nginx configtest && service nginx reload\"";
		MSG="Restarting Nginx on $NAME";
	;;
	majbd)
		CMD="cd /home/docker/private/db; git fetch; git checkout origin/master -- latest.dump; cd /home/docker/clara; ./restore_db_latest.sh;"
		MSG="Updating DB on $NAME...";
	;;
	*)
		usage;
		exit 1;
	;;
esac

echo -en "\x1b[92m";
echo "$MSG";
echo -en "\x1b[0m";

echo -en "\x1b[93m";
read -p "Continue ? (o/N): " -r;
echo -en "\x1b[0m";

if [[ $REPLY =~ ^[YyOo]$ ]]
then
	ssh -Ct livraison@$IP "$CMD";
else
	echo "Abort !";
fi

