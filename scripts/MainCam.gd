extends Camera2D

var lerping = false
var quad = Vector2(0, 0)
var supposed_pos = Vector2(1, 1)
func _ready():
	pass

func _process(delta):
	var boy_pos = $"../Boy".get_global_transform().get_origin()
	boy_pos = get_transform().inverse() * boy_pos
	
	if not lerping:
		lerping = true
		if boy_pos.x > get_viewport_rect().size.x:
			quad.x += 1
		elif boy_pos.x < 0:
			quad.x -= 1
		else:
			lerping = false
		
		if boy_pos.y > get_viewport_rect().size.y:
			quad.y += 1
		elif boy_pos.y < 0:
			quad.y -= 1
		else:
			lerping = false
	
	supposed_pos = get_viewport_rect().size * quad
	if position.distance_to(supposed_pos) > 5:
		position = lerp(position, supposed_pos, 0.1)
	else:
		lerping = false
