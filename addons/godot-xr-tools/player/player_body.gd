@tool
class_name XRToolsPlayerBody
extends CharacterBody3D


## XR Tools Player Body Script
##
## This script manages the players physical body in the XR world.
## It handles movement, rotation, and collisions.
## It also provides a way for movement providers to apply motion to the player.


## Signal emitted when the player teleports
signal player_teleported(target_transform)

## Signal emitted when the player jumps
signal player_jumped()

## Signal emitted when the player moves
signal player_moved(delta_transform)


## Distance to consider the player "near" the ground
const NEAR_GROUND_DISTANCE := 0.1

## Distance to consider the player "on" the ground
const ON_GROUND_DISTANCE := 0.05


## Player radius
@export var player_radius : float = 0.4: set = set_player_radius

## Player head height
@export var player_head_height : float = 0.1

## Eye height offset
@export var eye_height_offset : float = 0.05

## Push rigid bodies
@export var push_rigid_bodies : bool = true

## Collision mask
@export var collision_mask_override : int = 0


## Default ground physics
@export var default_physics : XRToolsGroundPhysicsSettings = XRToolsGroundPhysicsSettings.new()


## Enable player body
@export var enabled : bool = true: set = set_enabled


## Current ground physics
var ground_physics : XRToolsGroundPhysicsSettings

## Ground node
var ground_node : Node3D

## Ground velocity
var ground_velocity : Vector3 = Vector3.ZERO

## Ground vector
var ground_vector : Vector3 = Vector3.UP

## Ground angle
var ground_angle : float = 0.0

## On ground flag
var on_ground : bool = false

## Near ground flag
var near_ground : bool = false

## Teleporting flag
var teleporting : bool = false

## Velocity of the players feet relative to the ground
var ground_control_velocity : Vector2 = Vector2.ZERO

## Up vector of the player
var up_player : Vector3 = Vector3.UP

## Up vector of the gravity
var up_gravity : Vector3 = Vector3.UP


# Internal state
var _in_physics_movement : bool = false
var _collision_node : CollisionShape3D
var _head_shape_cast : ShapeCast3D
var _movement_providers : Array = []
var _player_height_offset : float = 0.0
var _player_height_overrides : Dictionary = {}
var _player_height_override_enabled : bool = false
var _player_height_override_target : float = 0.0
var _previous_ground_node : Node3D
var _previous_ground_global : Vector3
var _previous_ground_local : Vector3

## The [XROrigin3D] node
@onready var origin_node : XROrigin3D = XRHelpers.get_xr_origin(self)

## The [XRCamera3D] node
@onready var camera_node : XRCamera3D = XRHelpers.get_xr_camera(self)

## The left hand [XRController3D] node
@onready var left_hand_node : XRController3D = XRHelpers.get_left_controller(self)

## The right hand [XRController3D] node
@onready var right_hand_node : XRController3D = XRHelpers.get_right_controller(self)


## Find the [XRToolsPlayerBody] instance for the specified node
static func find_instance(node : Node) -> XRToolsPlayerBody:
	return XRTools.find_xr_child(XRHelpers.get_xr_origin(node), "*", "XRToolsPlayerBody") as XRToolsPlayerBody


## Function to sort movement providers by order
func sort_by_order(a, b) -> bool:
	return true if a.order < b.order else false


# Add support for is_xr_class on XRTools classes
func is_xr_class(xr_name:  String) -> bool:
	return xr_name == "XRToolsPlayerBody"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():
		# In editing, keep player body linked to our origin
		set_as_top_level(false)
		transform = Transform3D()
	else:
		# Set as toplevel means our PlayerBody is positioned in global space.
		# It is not moved when its parent moves.
		set_as_top_level(true)
		if get_parent():
			# Make sure we're positioned correctly at the start.
			global_transform = get_parent().global_transform

	# Create our collision shape, height will be updated later
	var capsule = CapsuleShape3D.new()
	capsule.radius = player_radius
	capsule.height = 1.4
	_collision_node = CollisionShape3D.new()
	_collision_node.shape = capsule
	_collision_node.transform.origin = Vector3(0.0, 0.7, 0.0)
	add_child(_collision_node)

	# Create the shape-cast for head collisions
	_head_shape_cast = ShapeCast3D.new()
	_head_shape_cast.enabled = false
	_head_shape_cast.exclude_parent = true
	_head_shape_cast.margin = 0.01
	_head_shape_cast.collision_mask = collision_mask
	_head_shape_cast.max_results = 1
	_head_shape_cast.shape = SphereShape3D.new()
	_head_shape_cast.shape.radius = player_radius
	add_child(_head_shape_cast)

	# Get the movement providers ordered by increasing order
	_movement_providers = get_tree().get_nodes_in_group("movement_providers")
	_movement_providers.sort_custom(sort_by_order)

	# Propagate defaults
	_update_enabled()
	_update_player_radius()


func set_enabled(new_value) -> void:
	enabled = new_value
	if is_inside_tree():
		_update_enabled()

func _update_enabled() -> void:
	# Update collision_shape
	if _collision_node:
		_collision_node.disabled = !enabled

	# Update physics processing
	if enabled:
		set_physics_process(true)


func set_player_radius(new_value: float) -> void:
	player_radius = new_value
	if is_inside_tree():
		_update_player_radius()


func _update_player_radius() -> void:
	if _collision_node and _collision_node.shape:
		_collision_node.shape.radius = player_radius


func _physics_process(delta: float):
	# Do not run physics if in the editor
	if Engine.is_editor_hint():
		return

	# If disabled then turn of physics processing and bail out
	if !enabled:
		set_physics_process(false)
		return

	# We're handling physics right now
	_in_physics_movement = true

	# Remember where we are now
	var current_transform : Transform3D = global_transform

	# Calculate the players "up" direction and plane
	up_player = origin_node.global_transform.basis.y

	# Determine environmental gravity
	var gravity_state := PhysicsServer3D.body_get_direct_state(get_rid())
	var gravity = gravity_state.total_gravity

	# Update the kinematic body to be under the camera
	_update_body_under_camera(delta)

	# Allow the movement providers a chance to perform pre-movement updates. The providers can:
	# - Adjust the gravity direction
	for p in _movement_providers:
		if p.enabled:
			p.physics_pre_movement(delta, self)

	# Determine the gravity "up" direction and plane
	if gravity.is_equal_approx(Vector3.ZERO):
		# Gravity too weak - use player
		up_gravity = up_player
	else:
		# Use gravity direction
		up_gravity = -gravity.normalized()

	# Update the ground information
	_update_ground_information(delta)

	# Get the player body location before movement occurs
	var position_before_movement := global_transform.origin

	# Run the movement providers in order.
	ground_control_velocity = Vector2.ZERO
	var exclusive := false
	for p in _movement_providers:
		if p.is_active or (p.enabled and not exclusive):
			if p.physics_movement(delta, self, exclusive):
				exclusive = true

	# If no controller has performed an exclusive-update then apply gravity and
	# perform any ground-control
	if !exclusive:
		if on_ground and ground_physics.stop_on_slope and ground_angle < ground_physics.move_max_slope:
			# Apply gravity towards slope to prevent sliding
			velocity += -ground_vector * gravity.length() * delta
		else:
			# Apply gravity
			velocity += gravity * delta
		_apply_velocity_and_control(delta)

	# Apply the player-body movement to the XR origin
	var movement := global_transform.origin - position_before_movement
	origin_node.global_transform.origin += movement

	# Orient the player towards (potentially modified) gravity
	slew_up(up_gravity, 5.0 * delta)

	# If we moved our player, emit signal
	var delta_transform : Transform3D = global_transform * current_transform.inverse()
	if delta_transform.origin.length() > 0.001:
		player_moved.emit(delta_transform)

	# And we're done!
	_in_physics_movement = false


## Teleport the player body.
func teleport(target : Transform3D) -> void:
	var inv_global_transform : Transform3D = global_transform.inverse()
	var player_to_origin : Transform3D = inv_global_transform * origin_node.global_transform
	global_transform = target
	origin_node.global_transform = target * player_to_origin
	player_teleported.emit(target * inv_global_transform)


## Request a jump
func request_jump(skip_jump_velocity := false):
	if !on_ground: return
	var ground_relative := velocity - ground_velocity
	if abs(ground_relative.dot(ground_vector)) > 0.01: return
	var jump_velocity := XRToolsGroundPhysicsSettings.get_jump_velocity(ground_physics, default_physics)
	if jump_velocity == 0.0: return
	var max_slope := XRToolsGroundPhysicsSettings.get_jump_max_slope(ground_physics, default_physics)
	if ground_angle > max_slope: return
	if !skip_jump_velocity:
		velocity += ground_vector * jump_velocity * XRServer.world_scale
	emit_signal("player_jumped")


## This method moves the players body using the provided velocity.
func move_player(p_velocity: Vector3) -> Vector3:
	velocity = p_velocity
	move_and_slide()
	return velocity


## This method rotates the player by rotating the [XROrigin3D] around the camera.
func rotate_player(angle: float):
	var inv_global_transform : Transform3D = global_transform.inverse()
	var t1 := Transform3D(); var t2 := Transform3D(); var rot := Transform3D()
	t1.origin = -camera_node.transform.origin
	t2.origin = camera_node.transform.origin
	rot = rot.rotated(Vector3.DOWN, angle)
	origin_node.transform = (origin_node.transform * t2 * rot * t1).orthonormalized()
	if not _in_physics_movement:
		player_moved.emit(global_transform * inv_global_transform)


## This method slews the players up vector
func slew_up(up: Vector3, slew: float) -> void:
	if up.is_equal_approx(Vector3.ZERO): return
	var current_origin := origin_node.global_transform
	var ref_pos_global := global_position
	var ref_pos_local : Vector3 = ref_pos_global * current_origin
	var target_origin := current_origin
	target_origin.basis.y = up.normalized()
	target_origin.basis.x = target_origin.basis.y.cross(target_origin.basis.z).normalized()
	target_origin.basis.z = target_origin.basis.x.cross(target_origin.basis.y).normalized()
	target_origin.origin = ref_pos_global - target_origin.basis * ref_pos_local
	origin_node.global_transform = current_origin.interpolate_with(target_origin, slew).orthonormalized()


# Internal update ground information
func _update_ground_information(delta: float):
	var ground_collision := move_and_collide(up_gravity * -NEAR_GROUND_DISTANCE, true)
	if !ground_collision:
		near_ground = false; on_ground = false; ground_vector = up_gravity; ground_angle = 0.0
		ground_node = null; ground_physics = null; _previous_ground_node = null
		return
	near_ground = true
	on_ground = ground_collision.get_travel().length() <= ON_GROUND_DISTANCE
	ground_vector = ground_collision.get_normal()
	ground_angle = rad_to_deg(ground_collision.get_angle(0, up_gravity))
	ground_node = ground_collision.get_collider()
	var physics_node := ground_node.get_node_or_null("GroundPhysics") as XRToolsGroundPhysics
	ground_physics = XRToolsGroundPhysics.get_physics(physics_node, default_physics)
	if ground_angle > 85: on_ground = false
	if _previous_ground_node == ground_node:
		var pos_old := _previous_ground_global
		var pos_new := ground_node.to_global(_previous_ground_local)
		ground_velocity = (pos_new - pos_old) / delta
	_previous_ground_node = ground_node
	_previous_ground_global = ground_collision.get_position()
	_previous_ground_local = ground_node.to_local(_previous_ground_global)


# Internal apply velocity and control
func _apply_velocity_and_control(delta: float):
	var local_velocity := velocity - ground_velocity
	var horizontal_velocity := local_velocity.slide(up_gravity)
	var vertical_velocity := local_velocity - horizontal_velocity
	if on_ground and ground_control_velocity.length() >= 0.1:
		var camera_transform := camera_node.global_transform
		var dir_forward := camera_transform.basis.z.slide(up_gravity).normalized()
		var dir_right := camera_transform.basis.x.slide(up_gravity).normalized()
		var control_velocity = (dir_forward * -ground_control_velocity.y + dir_right * ground_control_velocity.x) * XRServer.world_scale
		var current_traction := XRToolsGroundPhysicsSettings.get_move_traction(ground_physics, default_physics)
		var traction_factor: float = clamp(current_traction * delta, 0.0, 1.0)
		horizontal_velocity = horizontal_velocity.lerp(control_velocity, traction_factor)
	
	if on_ground and ground_control_velocity.length() < 0.1:
		var current_drag := XRToolsGroundPhysicsSettings.get_move_drag(ground_physics, default_physics)
		var drag_factor: float = clamp(current_drag * delta, 0, 1)
		horizontal_velocity = horizontal_velocity.lerp(Vector3.ZERO, drag_factor)

	velocity = move_player(horizontal_velocity + vertical_velocity + ground_velocity)


# Update the body under the camera
func _update_body_under_camera(_delta: float):
	var camera_transform := camera_node.transform
	var camera_position := camera_transform.origin
	var camera_offset := camera_position.slide(up_player)
	if camera_offset.length() > 0.001:
		origin_node.transform.origin += origin_node.transform.basis * camera_offset
		camera_node.transform.origin -= camera_offset
