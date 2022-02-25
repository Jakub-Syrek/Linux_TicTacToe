#!/bin/bash

RZAD1=("." "." ".")
RZAD2=("." "." ".")
RZAD3=("." "." ".")

ENDGAME=0
VICTORYRISK="NONE"
PLAYERS=0
MOVE="NONE"
CURRENTPLAYER=1

function display_board() {
	tput setaf 3; 	echo "  012"
	echo -n "A "
	for i in "${RZAD1[@]}"
	do
		tput setaf 1; echo -n "$i"
	done
	echo ""
	tput setaf 3; 	echo -n "B "
	for i in "${RZAD2[@]}"
        do
               tput setaf 1; echo -n "$i"
	done
	echo ""
	tput setaf 3; 	echo -n "C "
	for i in "${RZAD3[@]}"
        do
               tput setaf 1; echo -n "$i"
        done
	echo ""
	tput setaf 2; echo "--------------------------------"
}
function set_value() {
        if [ $1 = A ]
	then        
	RZAD1[$2]=$3
	fi
	if [ $1 = B ]
	then        
	RZAD2[$2]=$3
	fi
	if [ $1 = C ]
        then	
        RZAD3[$2]=$3
	fi
}
function get_value() {
	if [ $1 = A ]
        then
		echo ${RZAD1[$2]}
        fi
	if [ $1 = B ]
	then
		echo ${RZAD2[$2]}
	fi
	if [ $1 = C ]
        then
		echo ${RZAD3[$2]}
        fi	
}
arrVar=("");
function get_possibleMoves() {
	ind=0;
	for i in "${RZAD1[@]}"
        do		
	        if [ "$i" = "." ]
		then		
			val="A${ind};";
			arrVar+=${val};		
		fi
		ind=$((ind + 1));
        done
	ind=0;
        for i in "${RZAD2[@]}"
        do
		if [ "$i" = "." ]		
	        then
			val="B${ind};";
			arrVar+=${val};		
		fi        
		ind=$((ind + 1));
        done
	ind=0;	
        for i in "${RZAD3[@]}"
        do
		if [ "$i" = "." ]        
	        then
			val="C${ind};";
			arrVar+=${val};		
		fi
		ind=$((ind + 1));
	done	
	for i in "${arrVar[@]}"		
	do
		echo "$i"		
	done           
}
function play_random {
	IN=$(get_possibleMoves);
	MOVES=$(echo $IN | tr ";" "\n")
	ind=0;	
	for move in $(echo $IN | tr ";" "\n")
	do		
		ind=$((ind + 1))
	done
	ind=$((ind / 2))
	rnd=$(( ( RANDOM % ${ind} ) ))	
	ind1=0;  
        for move in $(echo $IN | tr ";" "\n")
        do
	if [ "$ind1" -eq "$(($rnd))" ]
	       	then
	    	var="$move";		
		first=${var:0:1};		
		second=${var:1:1};		
		set_value $first $second O
        fi
        ind1=$((ind1 + 1))	    
        done
}
function check_victory_conditions {
	varA1=$( get_value A 0 )
	varA2=$( get_value A 1 )
	varA3=$( get_value A 2 )
	varB1=$( get_value B 0 )
	varB2=$( get_value B 1 )
	varB3=$( get_value B 2 )
	varC1=$( get_value C 0 )
	varC2=$( get_value C 1 )
	varC3=$( get_value C 2 )
	
	if [ "$varA1" == "O" ] && [ "$varA2" == "O" ] && [ "$varA3" == "O" ]
	then
		ENDGAME=1;
		echo "o A victory"
	fi
	if [ "$varB1" == "O" ] && [ "$varB2" == "O" ] && [ "$varB3" == "O" ]
       	then
		ENDGAME=1;
                echo "o B victory"
        fi
	if [ "$varC1" == "O" ] && [ "$varC2" == "O" ] && [ "$varC3" == "O" ]
       	then
		ENDGAME=1;
                echo "o C victory"
        fi
	if [ "$varA1" == "O" ] && [ "$varB1" == "O" ] && [ "$varC1" == "O" ]
        then
                ENDGAME=1;
                echo "o 3 victory"
        fi
	if [ "$varA2" == "O" ] && [ "$varB2" == "O" ] && [ "$varC2" == "O" ]
        then
                ENDGAME=1;
                echo "o 3 victory"
        fi
	if [ "$varA3" == "O" ] && [ "$varB3" == "O" ] && [ "$varC3" == "O" ]
        then
                ENDGAME=1;
                echo "o 3 victory"
        fi
	if [ "$varA1" == "X" ] && [ "$varB1" == "X" ] && [ "$varC1" == "X" ]
        then
                ENDGAME=1;
                echo "x 3 victory"
        fi
        if [ "$varA2" == "X" ] && [ "$varB2" == "X" ] && [ "$varC2" == "X" ]
        then
                ENDGAME=1;
                echo "x 3 victory"
        fi
        if [ "$varA3" == "X" ] && [ "$varB3" == "X" ] && [ "$varC3" == "X" ]
        then
                ENDGAME=1;
                echo "x 3 victory"
        fi
	if [ "$varA1" == "X" ] && [ "$varA2" == "X" ] && [ "$varA3" == "X" ]
        then
                ENDGAME=1;
		echo "x A victory"
        fi
        if [ "$varB1" == "X" ] && [ "$varB2" == "X" ] && [ "$varB3" == "X" ]
        then
		ENDGAME=1;
		echo "x B victory"
        fi
        if [ "$varC1" == "X" ] && [ "$varC2" == "X" ] && [ "$varC3" == "X" ]
        then
                ENDGAME=1;
		echo "x C victory"
        fi
	if [ "$varA1" == "O" ] && [ "$varB2" == "O" ] && [ "$varC3" == "O" ]
        then
                ENDGAME=1;
		echo "o diagonal victory"
        fi
	if [ "$varA3" == "O" ] && [ "$varB2" == "O" ] && [ "$varC1" == "O" ]
        then
                ENDGAME=1;
		echo "o diagonal victory"
        fi
	if [ "$varA1" == "X" ] && [ "$varB2" == "X" ] && [ "$varC3" == "X" ]
        then
                ENDGAME=1;
		echo "x diagonal victory"
        fi
        if [ "$varA3" == "X" ] && [ "$varB2" == "X" ] && [ "$varC1" == "X" ]
        then
                ENDGAME=1;
	echo "x diagonal victory"
        fi
}
function check_potential_victory_conditions() {
        varA1=$( get_value A 0 )
        varA2=$( get_value A 1 )
        varA3=$( get_value A 2 )
        varB1=$( get_value B 0 )
        varB2=$( get_value B 1 )
        varB3=$( get_value B 2 )
        varC1=$( get_value C 0 )
        varC2=$( get_value C 1 )
        varC3=$( get_value C 2 )

        if [ "$varA1" == "X" ] && [ "$varA2" == "X" ] && [ "$varA3" == "." ]
        then
                VICTORYRISK="A2";
                echo ${VICTORYRISK}
	fi
	if [ "$varA1" == "X" ] && [ "$varA2" == "." ] && [ "$varA3" == "X" ]
        then
                VICTORYRISK="A1";
                echo ${VICTORYRISK}
        fi
	if [ "$varA1" == "." ] && [ "$varA2" == "X" ] && [ "$varA3" == "X" ]
        then
                VICTORYRISK="A0";
                echo ${VICTORYRISK}
        fi
	if [ "$varB1" == "X" ] && [ "$varB2" == "X" ] && [ "$varB3" == "." ]
        then
                VICTORYRISK="A2";
                echo ${VICTORYRISK}
        fi
        if [ "$varB1" == "X" ] && [ "$varB2" == "." ] && [ "$varB3" == "X" ]
        then
                VICTORYRISK="B1";
                echo ${VICTORYRISK}
        fi
        if [ "$varB1" == "." ] && [ "$varB2" == "X" ] && [ "$varB3" == "X" ]
        then
                VICTORYRISK="B0";
                echo ${VICTORYRISK}
        fi
	if [ "$varC1" == "X" ] && [ "$varC2" == "X" ] && [ "$varC3" == "." ]
        then
                VICTORYRISK="C2";
                echo ${VICTORYRISK}
        fi
        if [ "$varC1" == "X" ] && [ "$varC2" == "." ] && [ "$varC3" == "X" ]
        then
                VICTORYRISK="C1";
                echo ${VICTORYRISK}
        fi
        if [ "$varC1" == "." ] && [ "$varC2" == "X" ] && [ "$varC3" == "X" ]
        then
                VICTORYRISK="C0";
                echo ${VICTORYRISK}
        fi
	if [ "$varA1" == "X" ] && [ "$varB1" == "X" ] && [ "$varC1" == "." ]
        then
                VICTORYRISK="C0";
                echo ${VICTORYRISK}
        fi
	if [ "$varA1" == "X" ] && [ "$varB1" == "." ] && [ "$varC1" == "X" ]
        then
                VICTORYRISK="B0";
                echo ${VICTORYRISK}
        fi
	if [ "$varA1" == "." ] && [ "$varB1" == "X" ] && [ "$varC1" == "X" ]
        then
                VICTORYRISK="A0";
                echo ${VICTORYRISK}
        fi
	if [ "$varA2" == "X" ] && [ "$varB2" == "X" ] && [ "$varC2" == "." ]
        then
                VICTORYRISK="C1";
                echo ${VICTORYRISK}
        fi
        if [ "$varA2" == "X" ] && [ "$varB2" == "." ] && [ "$varC2" == "X" ]
        then
                VICTORYRISK="B1";
                echo ${VICTORYRISK}
        fi
        if [ "$varA2" == "." ] && [ "$varB2" == "X" ] && [ "$varC2" == "X" ]
        then
                VICTORYRISK="A1";
                echo ${VICTORYRISK}
        fi
	if [ "$varA3" == "X" ] && [ "$varB3" == "X" ] && [ "$varC3" == "." ]
        then
                VICTORYRISK="C2";
                echo ${VICTORYRISK}
        fi
        if [ "$varA3" == "X" ] && [ "$varB3" == "." ] && [ "$varC3" == "X" ]
        then
                VICTORYRISK="B2";
                echo ${VICTORYRISK}
        fi
        if [ "$varA3" == "." ] && [ "$varB3" == "X" ] && [ "$varC3" == "X" ]
        then
                VICTORYRISK="A2";
                echo ${VICTORYRISK}
        fi
	if [ "$varA1" == "X" ] && [ "$varB2" == "X" ] && [ "$varC3" == "." ]
        then
                VICTORYRISK="C2";
                echo ${VICTORYRISK}
        fi
        if [ "$varA3" == "X" ] && [ "$varB2" == "X" ] && [ "$varC1" == "." ]
        then
                VICTORYRISK="C0";
                echo ${VICTORYRISK}
        fi
        if [ "$varB2" == "X" ] && [ "$varC3" == "X" ] && [ "$varA1" == "." ]
        then
                VICTORYRISK="A0";
                echo ${VICTORYRISK}
        fi
	if [ "$varB2" == "X" ] && [ "$varC1" == "X" ] && [ "$varA3" == "." ]
        then
                VICTORYRISK="A2";
                echo ${VICTORYRISK}
        fi
	}
function validate_number(){      	
	re='^[1-2]+$'
	if ! [[ $1 =~ $re ]]
       	then
		PLAYERS=0
		echo "error: Not a 1 nor 2"
	else
		PLAYERS=$1
		echo "$1 selected."
	fi
}
function validate_move(){
	inp=$1
	length=${#inp}
	if [ "$length" -ne "2" ]
	then
		MOVE="NONE";
		echo "Incorrect input length.";
	else
		var="$1";
                first=${var:0:1};
                second=${var:1:1};
		MOVE="$var"
		if [ "$first" != "A" ] && [ "$first" != "B" ] && [ "$first" != "C" ]
		then
			MOVE="NONE"
			echo "Incorrect input first letter"
		fi

		if [ "$second" != "0" ] && [ "$second" != "1" ] && [ "$second" != "2" ]
		then
			MOVE="NONE"
			echo "Incorrect input second letter"
		fi
	fi
}
function check_if_occupied (){
	var="$1";
        first=${var:0:1};
        second=${var:1:1};
	check=$( get_value $first $second )
	if [ "$check" != "." ]
	then
		echo "taken"
	fi
}
function get_number_of_players() {
	while [ "$PLAYERS" -eq "0" ]
	do
		tput setaf 2; echo "Please select number of human players (1 or 2)"
		read play
		validate_number $play
	done
}
function get_player_move(){
	while [ "$MOVE" == "NONE" ]
	do
		echo "$CURRENTPLAYER player please provide input:"
		read input
		if [ "$input" == "SAVE" ]
		then
			save_game
		fi
		if [ "$input" == "LOAD" ]
		then
			load_game
		fi
		if [ "$input" != "LOAD" ] && [ "$input" != "SAVE" ]
		then
			validate_move $input
			checker=$(check_if_occupied $input)
			if [ "$checker" == "taken" ]
			then
				echo "cell occupied"
				MOVE="NONE"
			fi
		fi
	done
}
function save_game(){

	varA0=$( get_value A 0 )
        varA1=$( get_value A 1 )
        varA2=$( get_value A 2 )
        varB0=$( get_value B 0 )
        varB1=$( get_value B 1 )
        varB2=$( get_value B 2 )
        varC0=$( get_value C 0 )
        varC1=$( get_value C 1 )
        varC2=$( get_value C 2 )
	
	echo $varA0 > "save.txt"
	echo $varA1 >> "save.txt"
	echo $varA2 >> "save.txt"
	echo $varB0 >> "save.txt"
	echo $varB1 >> "save.txt"
	echo $varB2 >> "save.txt"
	echo $varC0 >> "save.txt"
	echo $varC1 >> "save.txt"
	echo $varC2 >> "save.txt"
	echo $CURRENTPLAYER >> "save.txt"
	echo "game saved"	
}
function load_game() {
	declare -a array=()
	i=0

	while IFS= read -r line; do
		array[i]=$line
		let "i++"
	done < save.txt

	echo "game loaded"

	set_value A 0 "${array[0]}"
	set_value A 1 "${array[1]}"
	set_value A 2 "${array[2]}"
	set_value B 0 "${array[3]}"
	set_value B 1 "${array[4]}"
	set_value B 2 "${array[5]}"
	set_value C 0 "${array[6]}"
	set_value C 1 "${array[7]}"
	set_value C 2 "${array[8]}"

	CURRENTPLAYER="${array[9]}"

	display_board
}

function play_game() {

	get_number_of_players

	while [ "$ENDGAME" -eq 0 ]
	do
		if [ "$PLAYERS" -eq 1 ]
		then
			echo "Player 1"
			display_board
			get_player_move
		
	                var="$MOVE";
	                first=${var:0:1};
        	        second=${var:1:1};
           		set_value $first $second X;
		
                	MOVE="NONE"
                	display_board
                	check_victory_conditions
                	if [ "$ENDGAME" -eq 0 ]
                	then
                        	check_potential_victory_conditions
                        	if [ "$VICTORYRISK" != "NONE" ]
                        		then
                                	echo "Playing against risk"
                                	var="$VICTORYRISK";
                                	first=${var:0:1};
                                	second=${var:1:1};
                        		set_value $first $second O;
                        	else
                                	echo "Playing random"
                                	play_random
                        	fi
                        	display_board
                        	check_victory_conditions
                	fi
		fi

		if [ "$PLAYERS" -eq 2 ]
		then

			echo "Player 1"
			display_board
			get_player_move
			var="$MOVE";
			first=${var:0:1};
                        second=${var:1:1};
                        set_value $first $second X;
                        MOVE="NONE"
                        display_board
                        check_victory_conditions

			echo "Player 2"
                        get_player_move
                        var="$MOVE";
                        first=${var:0:1};
                        second=${var:1:1};
                        set_value $first $second O;
                        MOVE="NONE"
                        display_board
                        check_victory_conditions
		fi	
	done
}

play_game

exit 0;




























		

		



























t 0
