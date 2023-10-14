extends Actor

@onready var player: Player = get_node("/root/Main/Level/Actors/Player");

func _ready():
	super();

func _physics_process(delta):
	super(delta);

func _on_timer_timeout():
	if (player != null):
		var node = Node2D.new()
		node.position = position
		node.look_at(player.global_position);
		node.queue_free()

		action_attack(node.position, node.rotation);
