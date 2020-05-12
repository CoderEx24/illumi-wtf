extends RichTextLabel


func _ready():
	pass
	
func _process(_delta):
	var cam = $'../../MainCam'
	var boy = $'../../Boy'
	
	text = ''
	text += 'Quad in %s\nCam should in %s\nCam actually in %s\n' % [cam.quad, cam.supposed_pos, cam.position]
	
