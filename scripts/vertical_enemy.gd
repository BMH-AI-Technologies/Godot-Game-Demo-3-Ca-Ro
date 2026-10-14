extends GridEnemy
## BÀI TẬP: ghi đè cách di chuyển để địch đi dọc.
## Đã kế thừa moving, step, get_cell() và move_to() từ các lớp cha.
## Không dùng _process(): stage.gd gọi take_turn() sau mỗi lượt của Athena.

func take_turn(stage: Node2D) -> void:
	if not moving:
		return
	# TODO 1: Tính ô đích ở phía trên hoặc dưới ô hiện tại.
	# Gợi ý: đi dọc giữ nguyên cột x, thay đổi hàng y theo step.
	# Trong bài này, step = 1 là xuống; step = -1 là lên.
	var target := get_cell() # Tạm giữ nguyên ô để khung bài tập chạy được.
	if stage.is_blocked(target):
		# TODO 2: Đổi chiều rồi tính LẠI target theo chiều mới.
		# Gợi ý: đọc nhánh tương ứng trong enemy.gd, nhưng đổi trục di chuyển.
		pass
	if not stage.is_blocked(target):
		# TODO 3: Dùng hàm kế thừa để đưa địch đến target.
		# Gợi ý: GridPiece đã có hàm chuyển vị trí theo tọa độ ô.
		pass
	# Không gọi super.take_turn(stage): hàm cha sẽ cho địch đi ngang thêm một lượt.
	# Chưa hoàn thành các TODO thì địch này đứng yên, kể cả khi bật Moving.
