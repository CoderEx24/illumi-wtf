extends KinematicBody2D

export(int) var speed = 200
var GRAVITY = ProjectSettings.get_setting('physics/2d/default_gravity')
var player_sighted = false
var player_pos = Vector2()
var velocity = Vector2()
var player = null

func _ready():
	player = $'../../Boy'
	if not player:
		print('fuck')
	
func _physics_process(_delta):
	velocity = Vector2()
	if player_sighted:
		velocity = player.position.direction_to(position) * speed
	velocity.y += GRAVITY
	velocity.x *= -1
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _on_Sight_body_entered(body):
	if body.name != 'Boy':
		return
	player_sighted = true


func _on_Sight_body_exited(body):
	if body.name != 'Boy':
		return
	player_sighted = false

