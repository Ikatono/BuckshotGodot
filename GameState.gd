extends Node

var player1_active = false
var player_cuffed = false

#true for live, false for blank
var shells: Array[bool] = []

var player1_health = 0
var player2_health = 0

var items_per_round = 0
var max_health = 0

var player1_score = 0
var player2_score = 0
