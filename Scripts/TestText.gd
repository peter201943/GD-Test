extends RichTextLabel


func _ready():
	self.push_align(RichTextLabel.ALIGN_CENTER)
	self.add_text("\ntest")
	self.push_bold()
	self.push_align(RichTextLabel.ALIGN_RIGHT)
	self.add_text("YOU'D BETTER!!!")
	


