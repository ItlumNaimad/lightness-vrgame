# TO DO LISTA
- [x] Inicjalizacja repozytorium
- [x] Utworzenie pliku README
- [ ] Menu główne
- [/] Scena Player
- [ ] Pokój gry
- [ ] Przeciwnik Ballora
- [ ] Przeciwnik 2
- [ ] Generatory
- [ ] Pickupy
- [ ] SFXy
- [ ] Odgłosy podłogi aby pomóc w orientacji

## Rzecy do zanotowania
Staging.gd ma od linii 80 to:
```gdscript
## The [XROrigin3D] node used while staging
@onready var xr_origin : XROrigin3D = XRHelpers.get_xr_origin(self)

## The [XRCamera3D] node used while staging
@onready var xr_camera : XRCamera3D = XRHelpers.get_xr_camera(self)
```
Muszę podmienić jakoś XROrigin3D i XRCamera3D na scenę player.tscn
A potem ogarniać przejścia między scenami
