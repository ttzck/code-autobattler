class_name CodeBlockContainer extends PanelContainer

var _label := RichTextLabel.new()

var content : CodeBlock
var disable_drag

func _init(_content, set_container = true, _disable_drag = false):
	mouse_filter = MOUSE_FILTER_PASS
	_label.fit_content = true
	_label.bbcode_enabled = true
	_label.mouse_filter = MOUSE_FILTER_IGNORE
	_label.custom_minimum_size = Vector2(256 - 16, 0)
	_label.add_theme_font_override("mono_font", preload("res://fonts/JetBrainsMono/JetBrainsMonoNerdFont-Regular.ttf"))
	add_child(_label)
	
	_label.text = "[code]" + _content.get_code() + "[/code]"
	content = _content
	if set_container:
		content.container = self
	disable_drag = _disable_drag



func _get_drag_data(at_position):
	if Utils.disable_drag or disable_drag:
		return null
	var c = Control.new()
	var d = CodeBlockContainer.new(content, false)
	c.add_child(d)
	d.position = -at_position
	set_drag_preview(c)
	return self
