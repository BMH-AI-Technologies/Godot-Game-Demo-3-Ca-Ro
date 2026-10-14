class_name Athena
extends GridPiece
## Athena đọc phím và gửi yêu cầu. Game quyết định bước đó có hợp lệ không.

signal move_requested(direction: Vector2i)
signal died
var active := true

func _unhandled_input(event: InputEvent) -> void:
	# Các action được khai báo ở Project Settings > Input Map.
	# is_action_pressed bỏ nhả phím và tự lặp: mỗi lần bấm đi một ô.
	if not active:
		return
	if event.is_action_pressed("move_up"):
		move_requested.emit(Vector2i.UP)
	elif event.is_action_pressed("move_down"):
		move_requested.emit(Vector2i.DOWN)
	elif event.is_action_pressed("move_left"):
		move_requested.emit(Vector2i.LEFT)
	elif event.is_action_pressed("move_right"):
		move_requested.emit(Vector2i.RIGHT)
	else:
		return
	get_viewport().set_input_as_handled()

func die() -> void:
	if not active:
		return
	active = false
	$Sprite2D.modulate = Color("c96666")
	# Chỉ phát một lần, vì biến active chặn các lần gọi die() tiếp theo.
	$DeathSound.play()
	died.emit()
