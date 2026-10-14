class_name GridPiece
extends Node2D
## Lớp chung cho những đối tượng nằm trên bàn chơi.
## Mỗi ô cách nhau 70 pixel. Trong editor, bật Snap với bước (70, 70).
## Vị trí trong scene là dữ liệu gốc, có thể kéo thả để sửa màn chơi.

const CELL_SIZE := 70

func get_cell() -> Vector2i:
	return Vector2i((position / CELL_SIZE).round())

func move_to(cell: Vector2i) -> void:
	position = Vector2(cell) * CELL_SIZE
