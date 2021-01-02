This is the code associated with this post: 

In order to use the function that calculates the SPV for the players of a team you need to use the ```bigballR``` and ```GameTheory``` packages. 

```
library(bigballR)
library(GameTheory)
```

Then you can use the following script to obtain the players and lineups for the game of interest from the bigballR: 

```
pbp = get_play_by_play(4984560)
lineups <- get_lineups(play_by_play_data = pbp, keep.dirty = T, garbage.filter = F)
pitt_lineups = lineups[which(lineups$Team == "Pittsburgh"),]
pitt_players = unique(c(pitt_lineups$P1,pitt_lineups$P2,pitt_lineups$P3,pitt_lineups$P4, pitt_lineups$P5))
```

Finally, you can call the ```SPV``` function to get the results:

```
pitt_spv <- SPV(pitt_players,pitt_lineups)
```
