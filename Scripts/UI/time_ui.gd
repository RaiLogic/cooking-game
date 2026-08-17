extends Control

@onready var time_label: Label = $Time
@onready var meridium: Label = $Meridium


func _ready() -> void:
	time_label.text = (
		str("%02d" % time.hour) + " " + str("%02d" % time.minute)
		)
	time.time_changed.connect(update_time)	
	

func _process(delta: float) -> void:
	check_meridium()
	
func update_time(hour: int, minute: int) -> void:
	time_label.text = (
		str("%02d" % time.hour) + " " + str("%02d" % time.minute)
		)
	
	
func check_meridium() -> void:
	
	if time.is_morning:
		meridium.text = "AM"
	else:
		meridium.text = "PM"
