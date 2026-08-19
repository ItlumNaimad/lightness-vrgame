extends Node

## Globalny emiter sygnałów powiązanych z hałasem gracza
@warning_ignore("unused_signal")
signal noise_emitted(global_pos: Vector3, noise_level: float)
