extends Node2D

@export var actor: Actor;

func _physics_process(_delta):
	process_input();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process_input():
	if (actor == null || actor.health <= 0):
		return;
		
	var is_attacking = action_attack();

	if (is_attacking):
		actor.velocity = Vector2.ZERO;
	else:
		actor.velocity = action_move();

func action_move() -> Vector2:
	var velocity = actor.velocity;
	var moving = false;
	
	if (Input.is_action_pressed("move_up")):
		velocity.y -= actor.speed * actor.gravity;
		moving = true;
	if (Input.is_action_pressed("move_down")):
		velocity.y += actor.speed * actor.gravity;
		moving = true;
	if (Input.is_action_pressed("move_left")):
		velocity.x -= actor.speed * actor.gravity;
		moving = true;
	if (Input.is_action_pressed("move_right")):
		velocity.x += actor.speed * actor.gravity;
		moving = true;

	if (moving):
		actor.animated_sprite_2d.play("walk");
		actor.animated_sprite_2d.flip_h = velocity.x < 0;
	else:
		actor.animated_sprite_2d.play("idle");

	return velocity;

func action_attack() -> bool:
	if (Input.is_action_just_pressed("attack")):
		var mouse_position = get_global_mouse_position();

		var node = Node2D.new();
		node.position = actor.position;
		node.look_at(mouse_position);
		node.queue_free();

		actor.action_attack(node.position, node.rotation, 30);

		return true;
		
	return false;
