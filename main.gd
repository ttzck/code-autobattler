extends Control

@onready var player = Program.new($ThreadContainerPlayer, $StatusContainerPlayer)
@onready var enemy = Program.new($ThreadContainerEnemy, $StatusContainerEnemy)

func _ready() -> void:
	player.thread.add_code_block(Training.new())
	player.thread.add_code_block(Punsh.new())
	player.hp = 10
	player.is_player = true
	
	for i in 5: 
		enemy.thread.add_code_block(Meditate.new(), true)
	enemy.thread.add_code_block(ThousandNeedles.new(), true)
	enemy.hp = 10
	
	$ButtonStart.pressed.connect(start_battle)
	$ButtonEnemy.pressed.connect(show_enemy)
	$ButtonInventory.pressed.connect(show_inventory)
	

func start_battle():
	hide_buttons()
	show_enemy()
	Utils.disable_drag = true
	
	var active = player
	var other = enemy
	
	while player.hp > 0 and enemy.hp > 0:
		await get_tree().create_timer(.1).timeout
		await active.step(other)
		active = other
		other = player if active == enemy else enemy
	
	await get_tree().create_timer(1.0).timeout
	
	player.reset_stats()
	enemy.reset_stats()
	
	Utils.disable_drag = false
	
	show_inventory()
	show_buttons()
	
	$LootContainer.add_code_block(ThousandNeedles.new())
	$LootContainer.add_code_block(Meditate.new())
	$LootContainer.add_code_block(Meditate.new())
	

func show_inventory():
	$StatusContainerEnemy.hide()
	$ThreadContainerEnemy.hide()
	$InventoryContainer.show()
	$LootContainer.show()
	
func show_enemy():
	$StatusContainerEnemy.show()
	$ThreadContainerEnemy.show()
	$InventoryContainer.hide()
	$LootContainer.hide()
	
	
func show_buttons():
	$ButtonStart.show()
	$ButtonEnemy.show()
	$ButtonInventory.show()
	
	
func hide_buttons():
	$ButtonStart.hide()
	$ButtonEnemy.hide()
	$ButtonInventory.hide()
	

func _process(_delta):
	if player.thread.thread_size > 0:
		$ProgramPointerPlayer.global_position.y = $ThreadContainerPlayer.get_code_block_container(player.i).global_position.y
	if enemy.thread.thread_size > 0:
		$ProgramPointerEnemy.global_position.y = $ThreadContainerEnemy.get_code_block_container(enemy.i).global_position.y
	$ThreadSizeLabel.text = str(player.thread.thread_size) + " / " + str(player.thread.max_thread_size)
