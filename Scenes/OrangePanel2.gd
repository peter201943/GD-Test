extends Panel

func _ready():
	#self.connect("orange_signal", self, "_change_color")
	# Note, we need to connect the TARGET to a LISTENER
	# This requires having a REFERENCE to facilitate this connection
	get_parent().get_node("OrangePanel1").connect("orange_signal", self, "_change_color")

func _change_color():
	print("Got Signal!")
	#self.get_stylebox().bg_color = Color(0.1,0.1,0.1,0.0)
	#self.get_stylebox().set_bg_color
	# https://godotengine.org/qa/12842/how-do-i-change-the-background-colour-of-a-panel-node
	# https://godotengine.org/qa/62070/adding-panel-via-script-no-background
	# Golly, Godot has some really awful documentation on this aspect!
	self.add_color_override("nu_color", Color(0.1, 0.1, 0.1, 0.0))
	self.get_node("OrangeLabel").text = "ARG"
	# https://www.gotut.net/godot-signals/
	# https://www.reddit.com/r/godot/comments/4n8rts/explain_to_me_how_to_use_the_signals_in_godot/
