extends Panel



func _ready():
	pass 


func _on_Button_pressed():
	self.get_parent().remove_child(self)
