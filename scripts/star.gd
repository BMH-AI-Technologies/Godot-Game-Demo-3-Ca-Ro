class_name CollectibleStar
extends GridPiece
## Ngôi sao tự quản lý việc được nhặt, báo cho game bằng signal.

signal collected
var taken := false

func collect() -> void:
	if taken:
		return
	taken = true
	hide()
	# Node âm thanh vẫn phát khi hình ngôi sao đã ẩn.
	$PickupSound.play()
	collected.emit()
	# Giữ node ẩn đến hết màn để không cần xử lý xóa node giữa lượt.
