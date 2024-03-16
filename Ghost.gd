extends RigidBody2D

signal hit
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() # Replace with function body.
