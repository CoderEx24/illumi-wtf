extends Control

var health_delta = 0
var bullets_delta = 0
var prev_health_scale = 1
var prev_bullet_scale = 1
onready var health_bar = $'Health Bar'
onready var bullet_bar = $'bullet Bar'

func _ready():
	Game.connect('health_changed', self, '_on_health_changed')
	Game.connect('bullets_changed', self, '_on_bullets_changed')
	Game.connect('score_changed', self, '_on_score_changed')
	Game.connect('niwtfit_changed', self, '_on_niwtfit_changed')
	Game.connect('lives_changed', self, '_on_lives_changed')
	$Score.text = str(Game.score)
	$Niwtfit/Count.text = str(Game.niwtfit)
	$Lives/Count.text = str(Game.lives)
	$Key.visible = false

func _process(delta):
	if Game.has_key:
		$Key.visible = true
	
	health_bar.rect_scale.x = lerp(health_bar.rect_scale.x, max(prev_health_scale - health_delta, 0), 0.7)
	bullet_bar.rect_scale.x = lerp(bullet_bar.rect_scale.x, max(prev_bullet_scale - bullets_delta, 0), 0.7)
	
	if Game.health < Game.MAX_HEALTH / 4:
		health_bar.color = Color.red
	elif Game.health < Game.MAX_HEALTH / 2:
		health_bar.color = Color.yellow
	else:
		health_bar.color = Color.green
		
	
func _on_health_changed(old, new):
	health_delta = max(min(float(old - new) / Game.MAX_HEALTH, 1), 0)
	prev_health_scale = health_bar.rect_scale.x
	
func _on_bullets_changed(old, new):
	bullets_delta = max(min(float(old - new) / Game.MAX_BULLETS, 1), 0)
	prev_bullet_scale = bullet_bar.rect_scale.x

func _on_lives_changed(old, new):
	print('new live count is %d' % new)
	$'Lives/Count'.text = str(new)
	
func _on_score_changed(old, new):
	$Score.text = str(new)
	
func _on_niwtfit_changed(old, new):
	$Niwtfit/Count.text = str(new)
