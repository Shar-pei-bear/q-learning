# q-learning
q-learning using value iteration

Problem statement:

![alt text](https://github.com/Shar-pei-bear/q-learning/blob/master/map.png)

You’re a knight and you need to save the princess trapped in the castle shown on the map above.

You can move one tile at a time. The enemy can’t, but land on the same tile as the enemy, and you will die. Your goal is to go the castle by the fastest route possible. This can be evaluated using a “points scoring” system.

You lose -1 at each step (losing points at each step helps our agent to be fast).
If you touch an enemy, you lose -100 points, and the episode ends.
If you are in the castle you win, you get +100 points.
