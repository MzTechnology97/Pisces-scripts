#!/bin/bash

function isRoot() {
	if [ "${EUID}" -ne 0 ]; then
		echo "Hai bisogno dei permessi root per eseguire questo script! Esegui prima un 'sudo su'"
		exit 1
	fi
}

function initialQuestions() {
        echo " Bene! Possiamo iniziare con l'ottimizzazione del tuo Pisces!"
        echo ""
        echo ""
        echo ""
        echo ""
        read -n1 -r -p "Premi qualsiasi tasto per continuare..."
        
}
 
function manageMenu() {
       echo "Cosa vorresti fare?"
	     echo "   1) Cancellare tutti i dati della Blockchain ed eseguire immediatamente un fastsyc"
	     echo "   2) Fix PacketForwarder Issue"
	     echo "   3) Fix Dashboard not loading"
	     echo "   4) Get a new Snapshot"
	     echo "   5) Risolvi i problemi dei Not Found ERROR (Aumenta i Peerbook)"
	     echo "   6) Exit"
 
      until [[ ${MENU_OPTION} =~ ^[1-6]$ ]]; do
		read -rp "Select an option [1-6]: " MENU_OPTION
	done
	    case "${MENU_OPTION}" in
	      1)
		      clearBlockchain
		      ;;
	      2)
		      packetForwarder
		      ;;
	      3)
		      nginx
		      ;;
	      4)
		      newSnapshot
		      ;;
	      5)
		      peerBookIncrease
		      ;;
	      6)
		      #Check for full Disk
			df -h 
			echo "If your Disk Usage is below 100% you´re good to go!"
			echo ""
			echo "You can ignore most of the error Logs of Dashboard"
			echo "Just leave the device online"
			echo "If not run this script again and choose: Clear Blockchain Data and resync"
		      exit 0
		      ;;
	      esac
 
}


function clearBlockchain() {
		echo "Usiamo lo script del Fastsync di inigoflores!"
		
		local PS3='Please enter sub option: '
  		local options=("Install automation" "Clear Blockchain once" "Sub menu quit")
  		local opt
  		select opt in "${options[@]}"
  			do
      				case $opt in
          				"Install automation")
						wget https://raw.githubusercontent.com/moophlo/pisces-miner-scripts/main/crontab_job.sh -O - | sudo bash
						return
						;;
					"Clear Blockchain once")
						wget https://raw.githubusercontent.com/moophlo/pisces-miner-scripts/main/clear_resync.sh -O - | sudo bash
						return
						;;
          				"Sub menu quit")
              					return
              					;;
          				*) echo "invalid option $REPLY";;
      				esac
  			done
		
		
		
}

function packetForwarder() {
		
		echo "By using this fix you will change some files in your Hotspot"
		echo "If you´re sure what you´re doing go ahead an choos an option"
		echo "This script uses the Pkt Fwd Fix of inigoflores!"
		echo ""
		local PS3='Please enter sub option: '
  		local options=("Fix issue" "Sub menu quit")
  		local opt
  		select opt in "${options[@]}"
  			do
      				case $opt in
          				"Fix issue")
             				 	sudo wget https://raw.githubusercontent.com/inigoflores/pisces-p100-tools/main/Packet_Forwarder_V2/update.sh -O - | sudo bash
             					return
						;;
          				"Sub menu quit")
              					return
              					;;
          				*) echo "invalid option $REPLY";;
      				esac
  			done
			
			
}
	
	
	
function nginx() {
		echo ""
		echo "Did you got the Dashboard error message:"
		echo "Bad Gateway Error 400 ?"
		echo "	1) Yes"
		echo "	2) No"
		
		until [[ ${MENU_OPTION} =~ ^[1-2]$ ]]; do
		read -rp "Select an option [1-2]: " MENU_OPTION
			
		done
	 	case "${MENU_OPTION}" in
	      		1)
		      		echo "open the Dashboard with https://yourmineripadress"
		     		;;
	     		 2)
		     		echo "You´re good nothing is wrong!"
				exit 0
		     		;;
	      
	      		esac
	
}
	
function newSnapshot() {
	
	wget https://raw.githubusercontent.com/moophlo/pisces-miner-scripts/main/clear_resync.sh -O - | sudo bash
}
	
function peerBookIncrease() {
	
		echo "Do you really want to change the Peerbook settings?"
		echo "This is testing only!!!"
		echo ""
		echo "You need to type in >>sudo docker exec miner miner peer book -c<< to see the increasement"
		echo ""
		echo "	1) Yes"
		echo "	2) No"
		echo "	3) Restore backup of sys.config"
		
		until [[ ${MENU_OPTION} =~ ^[1-2]$ ]]; do
		read -rp "Select an option [1-2]: " MENU_OPTION
			
		done
	 	case "${MENU_OPTION}" in
	      		1)	
		      		wget https://raw.githubusercontent.com/WantClue/Pisces-scripts/main/peerbook_fix.sh -O - | sudo bash
		     		;;
	     		2)
		     		exit 0
		     		;;
	      		3)
				echo "currently no backup you need to do this manually"
				;;
	      		esac
	
}
	

initialQuestions
 manageMenu
