extends CanvasLayer

signal start_game
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#$StartTimer.start() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_score(score):
	$Score.text = str(score)

func update_timer(timer):
	$TimerLabel.text = str(int(timer))
	
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func game_over():
	show_message("Times up!")
	await $MessageTimer.timeout

	$Message.text = "Catch the Escaped Ghosts!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	start_game.emit() # Replace with function body.


func _on_message_timer_timeout():
	$MessageLabel.hide() # Replace with function body.
