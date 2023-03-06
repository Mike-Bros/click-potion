extends Node

signal potion_skill_level_up

var potion_skill = 1
var potion_exp = 0
var potion_total_exp = 0
var potion_next_exp = get_required_potion_experience(potion_skill + 1)

func can_brew(potion_difficulty):
	if potion_difficulty <= potion_skill:
		return true
	else:
		return false
		

func _on_main_potion_brewed(potion):
#	print(potion.get_child("PotionStats"))
	var payout = get_xp_payout(potion.difficulty)
	print("Granting xp for diff: " + str(potion.difficulty))
	print("diff->payout: " + str(potion.difficulty) + "-> " + str(payout))
	gain_experience(payout)

func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))

func get_xp_payout(difficulty):
	return round(pow(difficulty, .7) + difficulty * .1)


func get_required_potion_experience(potion_skill):
#	return round(pow(potion_skill, 1) + potion_skill * 2)
	return round(pow(potion_skill, 1.8) + potion_skill * 4 + 5)
	

func gain_experience(amount):
	potion_total_exp += amount
	potion_exp += amount
	while potion_exp >= potion_next_exp:
		potion_exp -= potion_next_exp
		level_up_potion_skill()
		
		
func level_up_potion_skill():
	potion_skill += 1
	potion_next_exp = get_required_potion_experience(potion_skill + 1)
	emit_signal("potion_skill_level_up")
