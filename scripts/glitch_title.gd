extends Label

@export var title_text: String = "LIGHTLESS"
@export var high_frequency_jitter: bool = true
@export var major_glitch_interval: float = 2.4
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
	_major_timer = major_glitch_interval + randf_range(-0.4, 0.6)
	if material is ShaderMaterial:
		_shader_mat = material

func _process(delta: float) -> void:
	if text.is_empty() or (text != title_text and not _is_major_glitching):
		text = title_text

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
				
				# Flashe kolorystyczne RGB
				if randf() < 0.5:
					modulate = Color(0.35, 0.85, 1.0, randf_range(0.7, 1.0))
					add_theme_color_override("font_shadow_color", Color(1.0, 0.1, 0.25, 0.95))
				else:
					modulate = Color(1.0, 0.3, 0.35, randf_range(0.7, 1.0))
					add_theme_color_override("font_shadow_color", Color(0.1, 0.8, 1.0, 0.95))
				
				add_theme_constant_override("shadow_offset_x", randi_range(-6, 6))
				add_theme_constant_override("shadow_offset_y", randi_range(-4, 4))
			
			# Shader glitch boost i vertex jitter
			if _shader_mat:
				_shader_mat.set_shader_parameter("glitch_intensity", randf_range(0.65, 1.0))
				_shader_mat.set_shader_parameter("jitter_offset", Vector2(randf_range(-12.0, 12.0), randf_range(-5.0, 5.0)))
		else:
			# Koniec mocnego glitchu - powrót do idealnego stanu
			_is_major_glitching = false
			text = title_text
			modulate = Color.WHITE
			add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.95))
			add_theme_constant_override("shadow_offset_x", 3)
			add_theme_constant_override("shadow_offset_y", 4)
			if _shader_mat:
				_shader_mat.set_shader_parameter("glitch_intensity", 0.0)
				_shader_mat.set_shader_parameter("jitter_offset", Vector2.ZERO)
		return

	# 3. Subtelne mikro-zakłócenia cyfrowe w tle (Ambient Micro-Jitter via Shader)
	if high_frequency_jitter:
		_jitter_timer += delta
		if _jitter_timer >= 0.04:
			_jitter_timer = 0.0
			var micro_x: float = randf_range(-1.2, 1.2) if randf() < 0.3 else 0.0
			var micro_y: float = randf_range(-0.8, 0.8) if randf() < 0.3 else 0.0
			
			if _shader_mat:
				_shader_mat.set_shader_parameter("jitter_offset", Vector2(micro_x, micro_y))
				_shader_mat.set_shader_parameter("glitch_intensity", randf_range(0.02, 0.08) if randf() < 0.25 else 0.0)

func _start_major_glitch() -> void:
	_is_major_glitching = true
	_major_glitch_time_left = major_glitch_duration + randf_range(-0.15, 0.2)
	_char_shuffle_timer = 0.0
