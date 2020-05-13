extends Node

signal health_changed(old, new)
signal score_changed(old, new)
signal niwtfit_changed(old, new)
signal bullets_changed(old, new)
signal lives_changed(old, new)
const MAX_HEALTH = 1000.0
const MAX_BULLETS = 50

var niwtfit = 0 setget _set_niwtfit
var health = MAX_HEALTH setget _set_health
var bullets = MAX_BULLETS setget _set_bullets
var lives = 4 setget _set_lives
var level = 0 setget _set_level
var score = 0 setget _set_score
var has_key = false setget _set_has_key
var is_game_over = false setget _set_is_game_over

func _ready():
	pass

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_R and not event.echo and event.pressed and score >= 300:
			get_tree().reload_current_scene()
			_set_score(score - 300)
			has_key = false

func _set_niwtfit(val):
	emit_signal('niwtfit_changed', niwtfit, val)
	niwtfit = val
	
func _set_health(val):
	emit_signal('health_changed', health, val)
	health = max(min(val, Game.MAX_HEALTH), 0)
	if health <= 0:
		print('lost a live')
		_set_lives(lives - 1)
		_set_health(Game.MAX_HEALTH)
		
func _set_lives(val):
	emit_signal('lives_changed', lives, val)
	if val < 0:
		_set_is_game_over(true)
	if val < lives:
		get_tree().reload_current_scene()
		has_key = false
	lives = val
	
func _set_score(val):
	emit_signal('score_changed', score, val)
	if (val % 1200) == 0:
		_set_health(max(health + Game.MAX_HEALTH * 0.1, Game.MAX_HEALTH))
	elif (val % 300) == 0:
		_set_bullets(max(bullets + Game.MAX_BULLETS * 0.5, Game.MAX_BULLETS))
	elif (val % 4000) == 0:
		_set_lives(lives + 1)
	score = val

func _set_has_key(val):
	has_key = val
	
func _set_is_game_over(val):
	is_game_over = val
	get_tree().quit()

func _set_bullets(val):
	emit_signal('bullets_changed', bullets, val)
	bullets = max(min(val, Game.MAX_BULLETS), 0)
	
func _set_level(val):
	if level != val:
		get_tree().change_scene('res://2d/levels/level_' + str(val) + '.tscn')
		has_key = false
	level = val
