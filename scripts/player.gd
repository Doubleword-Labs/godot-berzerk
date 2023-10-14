extends Actor

class_name Player

signal gameover

func action_die():
	var tween = get_tree().create_tween();
	tween.tween_callback(animated_sprite_2d.play.bind(&"death"));
	tween.tween_interval(2.0);
	tween.tween_callback(emit_signal.bind("gameover"))
	tween.tween_callback(queue_free)
