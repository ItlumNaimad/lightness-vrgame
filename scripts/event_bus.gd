extends Node

## Globalny emiter sygnałów powiązanych z hałasem gracza
@warning_ignore("unused_signal")
signal noise_emitted(global_pos: Vector3, noise_level: float)

## Sygnał wywoływany co próg przetrwania (np. co 10s) dla eskalacji trudności
@warning_ignore("unused_signal")
signal milestone_reached(milestone: int)

