if keyboard_check_pressed(ord("Q")){
	addItem("Katana");
}
if keyboard_check_pressed(ord("W")){
	addItem("Armor");
}
if keyboard_check_pressed(ord("E")){
	addItem("Water");
}
if keyboard_check_pressed(vk_escape){
	game_restart();
}
if keyboard_check_pressed(vk_delete){
	destroySelection();
}
if mouse_check_button(mb_left)^^global.SwappingItems{
	var split=keyboard_check(vk_shift)?true:false;
	var peel=keyboard_check(vk_control)?true:false;
	swapSelection(split,peel);
}

// Selection acquisition (mouse)
for (var w=0;w<COLS;w++){
	for (var h=0;h<ROWS;h++){
		var mx=device_mouse_x_to_gui(0),
		my=device_mouse_y_to_gui(0),
		xmax=ANCHORX+ICONSIZE*(w+1),
		ymax=ANCHORY+ICONSIZE*(h+1);
		if mx>ANCHORX&&mx<xmax&&my>ANCHORY&&my<ymax{
			ds_grid_clear(global.SelectionGrid,0);
			global.SelectionGrid[#w,h]=1;
			exit;
		}
		else{
			ds_grid_clear(global.SelectionGrid,0);
		}
	}
}