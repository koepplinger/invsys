// Developer controls
if keyboard_check_pressed(ord("Q")) itemAdd("Katana");
if keyboard_check_pressed(ord("W")) itemAdd("Armor");
if keyboard_check_pressed(ord("E")) itemAdd("Water");
if keyboard_check_pressed(DESTROKATANA) itemDestroy("Katana");

// Main logic loop
selectionUpdate();
if keyboard_check_pressed(QUIT) game_restart();
if keyboard_check_pressed(SAVE) systemFile("save");
if keyboard_check_pressed(LOAD) systemFile("load");
if keyboard_check_pressed(DESTROY) selectionDestroy();
if mouse_check_button(SWAP)^^Swapping{
	var split=keyboard_check(SPLIT);
	var peel=keyboard_check(PEEL);
	selectionSwap(split,peel);
}