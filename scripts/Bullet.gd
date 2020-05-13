extends KinematicBody2D

export(int) var speed = 4000
var velocity
var dir

func _ready():
	print('bullet shot')
	$Sprite.scale.x *= dir

func _physics_process(delta):
	velocity = Vector2(dir, 0) * speed
	var collision = move_and_collide(velocity * delta)
	if collision and collision.collider.has_method('get_hit'):
		collision.collider.get_hit()
		queue_free()
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
