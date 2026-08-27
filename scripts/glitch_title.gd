@tool
extends Label

@export var title_text: String = "LIGHTLESS"
@export var high_frequency_jitter: bool = true
@export var major_glitch_interval: float = 2.2
@export var major_glitch_duration: float = 1.05

const GLITCH_CHARS: Array[String] = [
	"!", "?", "#", "$", "%", "&", "/", "\\", "|",
	"░", "▒", "▓", "█", "▄", "▌", "▐", "▀",
	"§", "†", "‡", "Ø", "Æ", "¥", "¿", "¡", "X", "0",
	"1", "7", "<", ">", "[", "]", "{", "}", "~", "@", "*"
]

const CHAR_SHUFFLE_INTERVAL: float = 0.06 # Shuffles characters ~16 times per second during major glitch

var _major_timer: float = 0.0
var _is_major_glitching: bool = false
var _major_glitch_time_left: float = 0.0
var _char_shuffle_timer: float = 0.0
var _jitter_timer: float = 0.0
var _shader_mat: ShaderMaterial = null

func _ready() -> void:
	text = title_text
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	position = Vector2.ZERO
	pivot_offset = size * 0.5
	_major_timer = major_glitch_interval + randf_range(-0.4, 0.6)
	if material is ShaderMaterial:
		_shader_mat = material

func _process(delta: float) -> void:
	if text.is_empty() or (text != title_text and not _is_major_glitching):
		text = title_text
		
	if pivot_offset == Vector2.ZERO and size != Vector2.ZERO:
		pivot_offset = size * 0.5

	if _shader_mat == null and material is ShaderMaterial:
		_shader_mat = material

	# 1. Odliczanie do kolejnego mocnego glitchu
	_major_timer -= delta
	if _major_timer <= 0.0 and not _is_major_glitching:
		_start_major_glitch()
		_major_timer = major_glitch_interval + randf_range(-0.3, 0.5)

	# 2. Wykonywanie mocnego glitchu cyfrowego trwającego ok. 1 sekundy
	if _is_major_glitching:
		_major_glitch_time_left -= delta
		if _major_glitch_time_left > 0.0:
			_char_shuffle_timer -= delta
			if _char_shuffle_timer <= 0.0:
				_char_shuffle_timer = CHAR_SHUFFLE_INTERVAL
				
				# Dynamiczne przetasowanie liter
				var mangled: String = ""
				for i in range(title_text.length()):
					if randf() < 0.5:
						mangled += GLITCH_CHARS[randi() % GLITCH_CHARS.size()]
					else:
						mangled += title_text[i]
				text = mangled
				
				# Skoki pozycji wokół środka (bez dryfowania bazowego)
				var jump_x: float = randf_range(-14.0, 14.0)
				var jump_y: float = randf_range(-6.0, 6.0)
				position = Vector2(jump_x, jump_y)
				scale = Vector2(randf_range(0.96, 1.08), randf_range(0.94, 1.09))
				rotation_degrees = randf_range(-1.8, 1.8)
				
				# Flashe kolorystyczne RGB
				if randf() < 0.5:
					modulate = Color(0.35, 0.85, 1.0, randf_range(0.7, 1.0)) # Cyber Cyan
					add_theme_color_override("font_shadow_color", Color(1.0, 0.1, 0.25, 0.95)) # Red shadow split
				else:
					modulate = Color(1.0, 0.3, 0.35, randf_range(0.7, 1.0)) # Red
					add_theme_color_override("font_shadow_color", Color(0.1, 0.8, 1.0, 0.95)) # Cyan shadow split
				
				add_theme_constant_override("shadow_offset_x", randi_range(-6, 6))
				add_theme_constant_override("shadow_offset_y", randi_range(-4, 4))
			
			# Shader glitch boost
			if _shader_mat:
				_shader_mat.set_shader_parameter("glitch_intensity", randf_range(0.65, 1.0))
		else:
			# Koniec mocnego glitchu - powrót do idealnego centrum
			_is_major_glitching = false
			text = title_text
			position = Vector2.ZERO
			scale = Vector2.ONE
			rotation_degrees = 0.0
			modulate = Color.WHITE
			add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.95))
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
			var micro_x: float = randf_range(-1.0, 1.0)
			var micro_y: float = randf_range(-0.6, 0.6)
			position = Vector2(micro_x, micro_y)
			
			var alpha: float = randf_range(0.94, 1.0)
			modulate = Color(0.94, 0.97, 1.0, alpha)
			
			if _shader_mat:
				_shader_mat.set_shader_parameter("glitch_intensity", randf_range(0.02, 0.08) if randf() < 0.25 else 0.0)

func _start_major_glitch() -> void:
	_is_major_glitching = true
	_major_glitch_time_left = major_glitch_duration + randf_range(-0.15, 0.2)
	_char_shuffle_timer = 0.0
