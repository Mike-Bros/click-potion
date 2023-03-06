extends CanvasLayer

signal brew_button_pressed
signal potion_toggled(potion)

var menu_selection

func _ready():
	hide_all_node_children($RightMenuText)
	$PotionSelection/PotionButton1.left_clicked.connect(_on_potion_button_left_click.bind($PotionSelection/PotionButton1))
	$PotionSelection/PotionButton2.left_clicked.connect(_on_potion_button_left_click.bind($PotionSelection/PotionButton2))
	$PotionSelection/PotionButton3.left_clicked.connect(_on_potion_button_left_click.bind($PotionSelection/PotionButton3))
	$PotionSelection/PotionButton4.left_clicked.connect(_on_potion_button_left_click.bind($PotionSelection/PotionButton4))
	$PotionSelection/PotionButton5.left_clicked.connect(_on_potion_button_left_click.bind($PotionSelection/PotionButton5))
	$PotionSelection/PotionButton6.left_clicked.connect(_on_potion_button_left_click.bind($PotionSelection/PotionButton6))
	show_all_node_children($MenuButtons)

func _on_brew_button_pressed():
	emit_signal("brew_button_pressed")


func set_generic_label(text, duration):
	$GenericLabel.text = text
	$GenericLabel.show()
	$GenericLabelTimer.wait_time = duration
	$GenericLabelTimer.start()


func _on_generic_label_timer_timeout():
	$GenericLabel.hide()
	

func _on_potion_button_left_click(potion_button):
	emit_signal("potion_toggled",potion_button)
	
	
func hide_all_node_children(node):
	for n in node.get_children():
		n.hide()
		
		
func show_all_node_children(node):
	for n in node.get_children():
		n.show()


func _on_right_menu_text_hide_button_pressed():
	$RightMenuText.hide()
	show_all_node_children($MenuButtons)


func _on_level_info_show_button_pressed():
	menu_selection = "LevelInfo"
	hide_all_node_children($MenuButtons)
	$RightMenuText.show()
	$RightMenuText/RightMenuTextHideButton.show()
