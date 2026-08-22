@tool
extends Label

@export var title_text: String = "LIGHTLESS"
@export var high_frequency_jitter: bool = true
@export var major_glitch_interval: float = 4.0

const GLITCH_CHARS: Array[String] = [
	"!", "?", "#", "$", "%", "&", "/", "\\", "|",
	"░", "▒", "▓", "█", "▄", "▌", "▐", "▀",
	"§", "†", "‡", "Ø", "Æ", "¥", "¿", "¡", "X", "0"
]

var _base_position: Vector2 = Vector2.ZERO
var _major_timer: float = 0.0
var _is_major_glitching: bool = false
var _glitch_frames_left: int = 0
var _jitter_timer: float = 0.0

func _ready() -> void:
	text = title_text
	_base_position = position
	_major_timer = major_glitch_interval + randf_range(-0.5, 0.5)

func _process(delta: float) -> void:
	if text.is_empty() or (text != title_text and not _is_major_glitching):
		text = title_text
		
	if _base_position == Vector2.ZERO and position != Vector2.ZERO:
		_base_position = position

	# 1. Obsługa nagłego dużego glitchu co ~4 sekundy
	_major_timer -= delta
	if _major_timer <= 0.0 and not _is_major_glitching:
		_start_major_glitch()
		_major_timer = major_glitch_interval + randf_range(-0.6, 0.6)

	# 2. Wykonywanie dużego glitchu
	if _is_major_glitching:
		_glitch_frames_left -= 1
		if _glitch_frames_left > 0:
			var mangled: String = ""
			for i in range(title_text.length()):
				if randf() < 0.4:
					mangled += GLITCH_CHARS[randi() % GLITCH_CHARS.size()]
				else:
					mangled += title_text[i]
			text = mangled
			
			var jump_x: float = randf_range(-8.0, 8.0)
			var jump_y: float = randf_range(-4.0, 4.0)
			position = _base_position + Vector2(jump_x, jump_y)
			
			if randf() < 0.5:
				modulate = Color(0.7, 0.85, 1.0, randf_range(0.4, 0.95))
			else:
				modulate = Color(1.0, 0.75, 0.7, randf_range(0.5, 1.0))
		else:
			_is_major_glitching = false
			text = title_text
			position = _base_position
			modulate = Color.WHITE
		return

	# 3. Subtelne mikro-offsety o wysokiej częstotliwości (High-Frequency Micro-Jitter)
	if high_frequency_jitter:
		_jitter_timer += delta
		if _jitter_timer >= 0.04:
			_jitter_timer = 0.0
			var micro_x: float = randf_range(-0.8, 0.8)
			var micro_y: float = randf_range(-0.6, 0.6)
			position = _base_position + Vector2(micro_x, micro_y)
			
			var alpha: float = randf_range(0.92, 1.0)
			modulate = Color(0.95, 0.96, 1.0, alpha)

func _start_major_glitch() -> void:
	_is_major_glitching = true
	_glitch_frames_left = randi_range(6, 14)
