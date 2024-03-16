extends Node


@export var mob_scene: PackedScene
var score
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HUD.update_timer($PlayTimer.time_left)


func new_game():
	score = 0
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	$PlayTimer.start()
	$MobTimer.start()
	$Music.play()
	$HUD.update_score(score)
	

func update_score():
	$HUD.update_score(score)
	
func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob) # Replace with function body.


func _on_play_timer_timeout():
	$Music.stop()
	get_tree().call_group("mobs", "queue_free")
	$Player.hide() 
	$Player.set_deferred("disabled", false)
	$Player.get_node("CollisionShape2D").disabled = true
	$GameEndMusic.play()
	$HUD.game_over() # Replace with function body.
