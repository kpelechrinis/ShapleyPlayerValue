SPV <- function(players, lineups){
  
  ## players is a list of players used in the game of interest
  ## lineups is a data frame with the team lineups as provided by the output of bigballR 
  ## to do: add Bayesian adjustment of lineups based on mins/possessions 
  ## to do: optimize code syntax/readability
  
  v <- c()
  coalit = coalitions(length(players))
  b = coalit$Binary
  for (i in 2:dim(b)[1]){
     current_coal = which(!b[i,] == 0)
      if (length(current_coal) <= 5){
         tmp = get_player_lineups(lineups,Included = players[current_coal])
         v <- append(v,(100*(sum(tmp$PTS)-sum(tmp$oPTS))/sum(tmp$POSS)))
       }else{
         current_coal = which(b[i,] == 0)
         if (length(current_coal) == 0){
            tmp = lineups
            v <- append(v,(100*(sum(tmp$PTS)-sum(tmp$oPTS))/sum(tmp$POSS)))
         }else{
            tmp = get_player_lineups(lineups,Excluded  = players[current_coal])
            v <- append(v,(100*(sum(tmp$PTS)-sum(tmp$oPTS))/sum(tmp$POSS)))
         }
       }
  }
  v[which(is.nan(v))] = 0
  v[which(is.nan(v) | is.infinite(v))] = 0
  basket_game <- DefineGame(length(pitt_players),v)
  player_shapley <- ShapleyValue(basket_game,pitt_players)
  return(player_shapley)
}
