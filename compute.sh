gameinfo=`cat log/info.log  | grep MATCH_GAMEINFO | wc -l`

game=$[total-gameinfo]

matchfail=`cat log/info.log  | grep FAILED | wc -l`

realmatchfail=$[game-gameinfo-matchfail]

#rate=`echo "scale=4; $realmatchfail/$game" | bc`

awk 'BEGIN{printf "%.2f%\n",('$realmatchfail'/'$game')*100}'
#echo $rate
