@tool
extends Label

@export var title_text: String = "LIGHTLESS"
@export var high_frequency_jitter: bool = true
@export var major_glitch_interval: float = 1.6

const GLITCH_CHARS: Array[String] = [
	"!", "?", "#", "$", "%", "&", "/", "\\", "|",
	"░", "▒", "▓", "█", "▄", "▌", "▐", "▀",
	"§", "†", "‡", "Ø", "Æ", "¥", "¿", "¡", "X", "0",
	"1", "7", "<", ">", "[", "]", "{", "}", "~"
]

var _base_position: Vector2 = Vector2.ZERO
var _major_timer: float = 0.0
var _is_major_glitching: bool = false
var _glitch_frames_left: int = 0
var _jitter_timer: float = 0.0
var _shader_mat: ShaderMaterial = null

func _ready() -> void:
	text = title_text
	_base_position = position
	_major_timer = major_glitch_interval + randf_range(-0.3, 0.4)
	pivot_offset = size * 0.5
	if material is ShaderMaterial:
		_shader_mat = material

func _process(delta: float) -> void:
	if text.is_empty() or (text != title_text and not _is_major_glitching):
		text = title_text
		
	if _base_position == Vector2.ZERO and position != Vector2.ZERO:
		_base_position = position
		pivot_offset = size * 0.5

	if _shader_mat == null and material is ShaderMaterial:
		_shader_mat = material

	# 1. Odliczanie do kolejnego mocnego glitchu
	_major_timer -= delta
	if _major_timer <= 0.0 and not _is_major_glitching:
		_start_major_glitch()
		_major_timer = major_glitch_interval + randf_range(-0.4, 0.5)

	# 2. Wykonywanie mocnego glitchu cyfrowego
	if _is_major_glitching:
		_glitch_frames_left -= 1
		if _glitch_frames_left > 0:
			# Rozszczepienie i zniekształcenie tekstu
			var mangled: String = ""
			for i in range(title_text.length()):
				if randf() < 0.45:
					mangled += GLITCH_CHARS[randi() % GLITCH_CHARS.size()]
				else:
					mangled += title_text[i]
			text = mangled
			
			# Skoki pozycji, skali i rotacji
			var jump_x: float = randf_range(-12.0, 12.0)
			var jump_y: float = randf_range(-6.0, 6.0)
			position = _base_position + Vector2(jump_x, jump_y)
			scale = Vector2(randf_range(0.96, 1.08), randf_range(0.94, 1.09))
			rotation_degrees = randf_range(-1.8, 1.8)
			
			# Flashe kolorystyczne RGB
			if randf() < 0.5:
				modulate = Color(0.35, 0.85, 1.0, randf_range(0.65, 1.0)) # Cyber Cyan
				add_theme_color_override("font_shadow_color", Color(1.0, 0.1, 0.25, 0.95)) # Red shadow split
			else:
				modulate = Color(1.0, 0.3, 0.35, randf_range(0.65, 1.0)) # Red
				add_theme_color_override("font_shadow_color", Color(0.1, 0.8, 1.0, 0.95)) # Cyan shadow split
			
			add_theme_constant_override("shadow_offset_x", randi_range(-6, 6))
			add_theme_constant_override("shadow_offset_y", randi_range(-4, 4))
			
			# Shader glitch boost
			if _shader_mat:
				_shader_mat.set_shader_parameter("glitch_intensity", randf_range(0.6, 1.0))
		else:
			_is_major_glitching = false
			text = title_text
			position = _base_position
			scale = Vector2.ONE
			rotation_degrees = 0.0
			modulate = Color.WHITE
			add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.9))
			add_theme_constant_override("shadow_offset_x", 3)
			add_theme_constant_override("shadow_offset_y", 4)
			if _shader_mat:
				_shader_mat.set_shader_parameter("glitch_intensity", 0.0)
		return

	# 3. Subtelne mikro-zakłócenia cyfrowe w tle (Ambient Micro-Jitter)
	if high_frequency_jitter:
		_jitter_timer += delta
		if _jitter_timer >= 0.035:
			_jitter_timer = 0.0
			var micro_x: float = randf_range(-1.2, 1.2)
			var micro_y: float = randf_range(-0.8, 0.8)
			position = _base_position + Vector2(micro_x, micro_y)
			
			var alpha: float = randf_range(0.92, 1.0)
			modulate = Color(0.92, 0.96, 1.0, alpha)
			
			if _shader_mat:
				_shader_mat.set_shader_parameter("glitch_intensity", randf_range(0.02, 0.12) if randf() < 0.3 else 0.0)

func _start_major_glitch() -> void:
	_is_major_glitching = true
	_glitch_frames_left = randi_range(6, 15)
