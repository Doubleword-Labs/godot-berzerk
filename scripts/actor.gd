extends CharacterBody2D;
class_name Actor;

var Projectile = load("res://scenes/projectile.tscn");

var area_2d = Area2D.new();

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export_category("Actor")
@export var color: Color;
@export_range(1, 1000) var health: int = 1;
@export_range(0, 1000) var speed: int = 500;
@export_range(0, 10000) var gravity: int = 3500;
@export var projectiles_target: NodePath;
@export var collision_shape: CollisionShape2D;

func _ready():
	area_2d.collision_layer = collision_layer;
	area_2d.collision_mask = collision_mask;
	area_2d.collision_priority = collision_priority;
	area_2d.add_child(collision_shape.duplicate());
	add_child(area_2d);

func _process(_delta):
	if (health == 0):
		action_die();

func _physics_process(delta):
	velocity *= delta;
	move_and_slide();

func get_projectiles_target() -> Node:
	if projectiles_target.is_empty():
		var projectiles_target_node = Node.new()
		projectiles_target_node.name = 'Projectiles'
		add_child(projectiles_target_node)
		projectiles_target = projectiles_target_node.get_path()

	return get_node(projectiles_target)

func action_attack(projectile_position: Vector2, projectile_rotation: float, offset: int = 25):
	var projectile = Projectile.instantiate();
	projectile.position = projectile_position;
	projectile.rotation = projectile_rotation;
	projectile.move_local_x(offset);

	animated_sprite_2d.flip_h = projectile.position.x < position.x;

	get_projectiles_target().add_child(projectile);

	var tween = get_tree().create_tween();
	tween.tween_property(animated_sprite_2d, "animation", &"attack", 0);
	tween.tween_callback(animated_sprite_2d.play)
	tween.tween_interval(0.5)
	tween.tween_property(animated_sprite_2d, "animation", &"idle", 0);
	tween.tween_callback(animated_sprite_2d.play)

func take_damage(damage: int, _source: Object):
	health = max(health - damage, 0);

func action_die():
	queue_free();
