if keyboard_check_pressed(vk_space){
	addItem("Katana");
}
if keyboard_check_pressed(vk_control){
	addItem("Armor");
}
if keyboard_check_pressed(vk_shift){
	addItem("Water");
}
if keyboard_check_pressed(vk_escape){
	game_restart();
}
if keyboard_check_pressed(vk_delete){
	destroySelection();
}
if mouse_check_button(mb_left)^^global.SwappingItems{
	swapSelection();
}

///

// Selection acquisition (mouse)
for (var w=0;w<COLS;w++){
	for (var h=0;h<ROWS;h++){
		if device_mouse_x_to_gui(0)>ANCHORX
		&&device_mouse_x_to_gui(0)<ANCHORX+ICONSIZE*(w+1)
		&&device_mouse_y_to_gui(0)>ANCHORY
		&&device_mouse_y_to_gui(0)<ANCHORY+ICONSIZE*(h+1){
			ds_grid_clear(global.SelectionGrid,0);
			global.SelectionGrid[#w,h]=1;
			exit;
		}
		else{
			ds_grid_clear(global.SelectionGrid,0);
		}
	}
}