#!/bin/sh

#For developer's ease || You can run multiple services in background such as redis, solr etc.

#Creating a tracking file if it doesn't exists
file_exists () {
	if [ ! -e "process.tid" ]; then
   touch process.tid
   echo "file created!"
	else
	  echo "file already exists"
	fi
}

fallback_command () {
	echo "No such service(s) running."
	exit
}

#General logic for starting a particular service
start_service () {
	file_exists
	$1 >/dev/null 2>&1 & echo $2" "$! > process.tid
	echo "Starting "$2" at $!"
}

#General logic for stoping of already running service
stop_service () {
	cat process.tid | grep $1 | awk '{print $2}' | xargs kill || fallback_command
	echo "Stopping "$1"..."
	rm process.tid
}

stop_all_services () {
	cat process.tid | awk '{print $2}' | xargs kill
	echo "Stopping all services..."
	rm process.tid
}

start_all_services () {
	echo "Starting all services"
	display_control_logic 1 
}

display_control_logic () {
	case $1 in
		1) start_service "rails s -p 3000" "RAILS" ;;
		2) stop_service "RAILS" ;;
		3) start_all_services ;;
		4) stop_all_services ;;
		5) exit ;;
		*) echo "Please enter a valid option!" && display_start_menu ;;
	esac
}

display_start_menu () {
	echo "1. Start Rails Server"
	echo "2. Stop Rails Server"
	echo "3. Start all services"
	echo "4. Stop all services"
	echo "5. Exit from menu"
	echo "Enter your choice :"
	read choice

	display_control_logic $choice
}

display_start_menu