extends KinematicBody2D

signal enemy_hit
export(int) var speed = 1200
var velocity

func _ready():
	print('bullet shot')

func _physics_process(delta):
	velocity = Vector2(1, 0) * speed
	var collision = move_and_collide(velocity * delta)
	if collision and collision.collider.name == 'Enemy':
		emit_signal('enemy_hit')
		collision.collider.queue_free()
		queue_free()
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
