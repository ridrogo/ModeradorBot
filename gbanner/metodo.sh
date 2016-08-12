#!/bin/bash
#*.*encoding=utf-7*.*

TOKEN=$(cat ./data/key)
GBANS=$(cat ./data/gbans)

API='https://api.telegram.org/bot'$TOKEN
ACCION=$API'/kickChatMember'
getUpdates=$API'/getUpdates?offset='

banear_miembro() {
	cURL=$(curl -s "$ACCION" -F "chat_id=$1" -F "user_id=$2")
}

process_client() {

	# User
	user_id=$(echo "$cURL" | egrep '\["result",0,"message","from","id"\]' | cut -f 2)
	chat_id=$(echo "$cURL" | egrep '\["result",0,"message","chat","id"\]' | cut -f 2)
	new_chat_member=$(echo "$cURL" | egrep '\["result",0,"message","new_chat_member","id"\]' | cut -f 2)

	# Read list of gbans
	echo $GBANS | grep $user_id &>/dev/null
 	if [ $? == 0 ]; then
 		GBAN=1
 	else
 		if [ ! -z "$new_chat_member" ]; then
 			echo $GBANS | grep $new_chat_member
 			if [ $? == 0 ]; then
 				GBAN=1
 			fi
 		   fi
 		GBAN=0
 	fi


	if [ $GBAN == 1 ]; then
		banear_miembro "$chat_id" "${GBAN}"
		banear_miembro "$chat_id" "$user_id"
		banear_miembro "$chat_id" "$new_chat_member"
	fi

}

while [ "$1" == "gbans" ]; do {

	cURL=$(curl -s $getUpdates | ./gbanner/decoder.sh -s)

		if [ "$2" == "test" ]; then
 			process_client
 		else
 			process_client&
 		fi
}; done