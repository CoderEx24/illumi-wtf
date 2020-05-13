extends Camera2D

var lerping = false
var quad = Vector2(0, 0)
var supposed_pos = Vector2(1, 1)
func _ready():
	pass

func _process(delta):
	var boy_pos = $"../Boy".get_global_transform().get_origin()
	boy_pos = get_transform().inverse() * boy_pos
	
	if boy_pos.x > get_viewport_rect().size.x and not lerping:
		quad.x += 1
		lerping = true
	elif boy_pos.x < 0 and not lerping:
		quad.x -=1
		lerping = true
	
	supposed_pos = get_viewport_rect().size * quad
	if position.distance_to(supposed_pos) > 5:
		position = lerp(position, supposed_pos, 0.1)
	else:
		lerping = false
