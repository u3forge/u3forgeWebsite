extends Control

var res=Array()
export var objToHide=Array()
onready var mode=get_node("Mode")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("ColorRect").visible=false
	get_parent().get_node("Resume").visible=false
	get_parent().get_node("Portfolio").visible=false
	get_parent().get_node("Contact").visible=false
	
	var path="res://Scripts/detect_os.txt"
	var jscode=load_text_file(path)
	#print(jscode)
	var out = JavaScript.eval(jscode)
	
	if out == null:
		res.append("378")
		res.append("793")
	else:
		res=str(out).split("/")
		
	#pass


		
func load_text_file(path):
	var f = File.new()
	var err = f.open(path, File.READ)
	if err != OK:
		printerr("Could not open file, error code ", err)
		return ""
	var text = f.get_as_text()
	f.close()
	return text






# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Mode_toggled(button_pressed):
	if not button_pressed:
		get_node("ColorRect").visible=true
		get_node("MoveInstructions").visible=false
		get_node("DownLogo").visible=false
		get_node("DownLabel").visible=false
		for obj in objToHide:
			get_node(obj).visible=false
	if button_pressed:
		get_node("ColorRect").visible=false
		get_node("MoveInstructions").visible=true
		get_node("DownLogo").visible=true
		get_node("DownLabel").visible=true
		for obj in objToHide:
			get_node(obj).visible=true






func _on_ResumeBtn_button_down():
	get_parent().get_node("Resume").visible=true
	show_hide_obj(false)

func _on_PortfolioBtn_button_down():
	get_parent().get_node("Portfolio").visible=true
	show_hide_obj(false)

func _on_ContactBtn_button_down():
	get_parent().get_node("Contact").visible=true
	show_hide_obj(false)

func show_hide_obj(show):
	for obj in objToHide:
		get_node(obj).visible=show and mode.pressed
	visible=show

