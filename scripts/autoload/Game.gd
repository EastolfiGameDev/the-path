extends Node

const _AnimatorClass = preload("res://scripts/animations/Animator.gd")
const _GameStateClass = preload("res://scripts/game_state/GameState.gd")
const _PopupsClass = preload("res://scripts/popups/Popups.gd")

var Animator := _AnimatorClass.new()
var GameState := _GameStateClass.new()
var Popups := _PopupsClass.new()
