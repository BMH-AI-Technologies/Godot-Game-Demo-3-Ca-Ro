extends Node2D
## Nạp màn và giải quyết một lượt. Hình ảnh nằm trong các scene riêng.

# Thêm hoặc đổi thứ tự màn ở mục Stages trong Inspector của node Game.
@export var stages: Array[PackedScene] = []
enum State { PLAYING, LOST, WON }

var state := State.PLAYING
var stage_index := 0
var stage: GridStage
var collected := 0
var total_stars := 0
@onready var result_button: Button = $Result/Button
@onready var end_menu: PanelContainer = $Result/EndMenu

func _ready() -> void:
	result_button.pressed.connect(_on_result_pressed)
	$Reload.pressed.connect(restart_stage)
	if stages.is_empty():
		push_error("Hãy thêm ít nhất một scene vào Stages của node Game.")
		return
	load_stage(0)

func load_stage(index: int) -> void:
	# Tạo lại scene để khôi phục sao, Athena và địch.
	if is_instance_valid(stage):
		remove_child(stage)
		stage.queue_free()
	stage_index = index
	state = State.PLAYING
	collected = 0
	result_button.hide()
	end_menu.hide()
	stage = stages[index].instantiate()
	stage.position = Vector2(75, 112)
	add_child(stage)
	total_stars = stage.stars.get_child_count()
	stage.player.move_requested.connect(try_move)
	stage.player.died.connect(_on_player_died)
	for star in stage.stars.get_children():
		star.collected.connect(_on_star_collected)
	update_title()

func try_move(direction: Vector2i) -> void:
	if state != State.PLAYING:
		return
	var target := stage.player.get_cell() + direction
	if stage.is_blocked(target):
		return
	stage.player.move_to(target)
	# Kiểm tra trước và sau lượt địch để không đi xuyên qua địch.
	if stage.touches_enemy():
		stage.player.die()
		return
	stage.collect_star()
	stage.move_enemies()
	if stage.touches_enemy():
		stage.player.die()
		return
	# Chỉ thắng khi đủ sao và còn sống sau lượt địch.
	if collected == total_stars:
		state = State.WON
		stage.player.active = false
		show_result()

func _on_star_collected() -> void:
	collected += 1

func _on_player_died() -> void:
	state = State.LOST
	show_result()

func update_title() -> void:
	$StageLabel.text = "Màn %d / %d" % [stage_index + 1, stages.size()]

func show_result() -> void:
	# Một nút vừa báo kết quả, vừa cho người chơi tiếp tục bằng chuột.
	if state == State.LOST:
		result_button.text = "Bạn đã thua!\nChơi lại"
	elif stage_index == stages.size() - 1:
		# Hết các màn hiện có: mời người học tạo màn mới, không quay về màn 1.
		result_button.hide()
		$Result/EndMenu/Message.text = "Gio ban hay thu tao tiep man thu %d di!" % (stage_index + 2)
		end_menu.show()
		return
	else:
		result_button.text = "Hoàn thành màn!\nMàn tiếp theo"
	result_button.show()

func restart_stage() -> void:
	if not stages.is_empty():
		load_stage(stage_index)

func advance_stage() -> void:
	if state == State.WON and stage_index + 1 < stages.size():
		load_stage(stage_index + 1)

func _on_result_pressed() -> void:
	if state == State.WON:
		advance_stage()
	elif state == State.LOST:
		restart_stage()
