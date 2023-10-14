extends Actor

class_name Player

signal gameover

@onready var death_sound = $DeathExplosion

# Called when the node enters the scene tree for the first time.
func _ready():
	super();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta);

func action_die():
	var tween = get_tree().create_tween();
	tween.tween_callback(animated_sprite_2d.play.bind(&"death"));
	tween.tween_interval(2.0);
	tween.tween_callback(emit_signal.bind("gameover"))
