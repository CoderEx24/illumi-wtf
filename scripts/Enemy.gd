extends KinematicBody2D

export(int) var speed = 200
var GRAVITY = ProjectSettings.get_setting('physics/2d/default_gravity')
var player_sighted = false
var player_pos = Vector2()
var velocity = Vector2()
var can_see = false
var player = null

func _ready():
	player = $'../../Boy'
	if not player:
		print('fuck')
	
func _physics_process(_delta):
	velocity = Vector2()
	if player_sighted and can_see:
		velocity = player.position.direction_to(position) * speed
	velocity.y += GRAVITY
	velocity.x *= -1
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var obj = get_slide_collision(i)
		if obj.collider.name == 'Boy':
			Game.health -= 200
			queue_free()

func _on_Sight_body_entered(body):
	print('_on_Sight_body_entered')
	if body.name != 'Boy':
		return
	player_sighted = true

func get_hit():
	Game.score += 250
	queue_free()

func _on_Sight_body_exited(body):
	if body.name != 'Boy':
		return
	player_sighted = false

func _on_VisibilityNotifier2D_screen_entered():
	can_see = true

func _on_VisibilityNotifier2D_screen_exited():
	can_see = false
