##
##  Player class is template for all player states.
##  Passes animation player to states and player node
##  
##
extends Node

class_name player_state

# character2d and animation player nodes
var player
var animation

# Function enters state, behavior is defined here 
func enter_state(player_node, animation_player):

    player = player_node
    animation = animation_player

# Function can be used to exit state (though not necessary)
func exit_state():
    pass

# Function handles input within the state
func handle_input(_delta):
    pass


