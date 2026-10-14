class_name GridEnemy
extends GridPiece
## Lớp cha: địch đứng yên hoặc tuần tra ngang.
## Lớp con có thể ghi đè take_turn() để tạo cách di chuyển khác.

@export var moving := false # Kẻ địch có thể di chuyển hay không

# Chiều đi ngang: 1 là sang phải, -1 là sang trái.
var step := 1

func _ready() -> void:
	update_direction()

func take_turn(stage: Node2D) -> void:
	if not moving:
		return
	var target := get_cell() + Vector2i(step, 0)
	if stage.is_blocked(target):
		# Gặp đá hoặc biên thì quay đầu và tính lại ô đích.
		step *= -1
		target = get_cell() + Vector2i(step, 0)
	# Nếu bị kẹp giữa hai khối đá, địch đứng yên.
	if not stage.is_blocked(target):
		move_to(target)
	update_direction()

func update_direction() -> void:
	$Sprite2D.flip_h = moving and step < 0
