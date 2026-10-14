class_name GridStage
extends Node2D
## Mỗi màn có các instance thật, sửa trực tiếp trong editor.
## Stage trả lời câu hỏi về bàn cờ; game.gd điều phối thứ tự một lượt.

const WIDTH := 8
const HEIGHT := 7

@onready var player: Athena = $Player
@onready var stars: Node2D = $Stars
@onready var obstacles: Node2D = $Obstacles
@onready var enemies: Node2D = $Enemies

func is_blocked(cell: Vector2i) -> bool:
	if cell.x < 0 or cell.x >= WIDTH or cell.y < 0 or cell.y >= HEIGHT:
		return true
	for obstacle in obstacles.get_children():
		if obstacle.get_cell() == cell:
			return true
	return false

func touches_enemy() -> bool:
	for enemy in enemies.get_children():
		if player.get_cell() == enemy.get_cell():
			return true
	return false

func collect_star() -> void:
	for star in stars.get_children():
		if star.get_cell() == player.get_cell():
			star.collect()

func move_enemies() -> void:
	for enemy in enemies.get_children():
		enemy.take_turn(self)
