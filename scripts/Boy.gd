extends KinematicBody2D

var bullet_scene
export (int) var speed = 300
export (int) var jump_speed = 400

var velocity = Vector2()
var GRAVITY = ProjectSettings.get_setting('physics/2d/default_gravity')

func _ready():
	bullet_scene = load('res://2d/Bullet.tscn')

func get_input():
	velocity.x = 0
	if Input.is_action_pressed('right'):
		velocity.x += speed
		$BoySprite.scale.x = abs($BoySprite.scale.x)
	if Input.is_action_pressed('left'):
		velocity.x -= speed
		$BoySprite.scale.x = - abs($BoySprite.scale.x)
	if Input.is_action_just_pressed('jump') and is_on_floor():
		velocity.y -= jump_speed

func _process(_delta):
	if Input.is_action_just_released('shoot') and Game.bullets > 0:
		var new_bullet = bullet_scene.instance()
		new_bullet.global_position = global_position
		new_bullet.dir = $BoySprite.scale.normalized().x
		$'../Bullets'.add_child(new_bullet)
		Game.bullets -= 1

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))
