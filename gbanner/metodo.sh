#!/bin/bash
#*.*encoding=utf-8*.*

TOKEN=$(cat ./data/key)
GBANS=$(cat ./data/gbans)

URL='https://api.telegram.org/bot'$TOKEN

ACCION=$URL'/kickChatMember'

UPD_URL=$URL'/getUpdates?offset='
OFFSET=0

banear_miembro() {
	res=$(curl -s "$ACCION" -F "chat_id=$1" -F "user_id=$2")
}

process_client() {

	# User
	user_id=$(echo "$res" | egrep '\["result",0,"message","from","id"\]' | cut -f 2)
	chat_id=$(echo "$res" | egrep '\["result",0,"message","chat","id"\]' | cut -f 2)
	new_chat_member=$(echo "$res" | egrep '\["result",0,"message","new_chat_member","id"\]' | cut -f 2 | cut -d '"' -f 2)

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
		banear_miembro "$chat_id" "$user_id"
		banear_miembro "$chat_id" "$new_chat_member"
	fi

}

while [ "$1" == "gbans" ]; do {

	res=$(curl -s $UPD_URL$OFFSET | ./gbanner/decoder.sh -s)

	# Offset
	OFFSET=$(echo "$res" | egrep '\["result",0,"update_id"\]' | cut -f 2)
	OFFSET=$((OFFSET+1))

	if [ $OFFSET != 1 ]; then
		if [ "$2" == "test" ]; then
 			process_client
 		else
 			process_client&
 		fi
	fi

}; done