// Developer controls
if keyboard_check_pressed(ord("Q")) itemAdd("Katana");
if keyboard_check_pressed(ord("W")) itemAdd("Armor");
if keyboard_check_pressed(ord("E")) itemAdd("Water");
if keyboard_check_pressed(DESTROYKATANA) itemDestroy("Katana");

// Main logic loop
selUpdate();
if keyboard_check_pressed(QUIT) game_restart();
if keyboard_check_pressed(SAVE) systemFile("save");
if keyboard_check_pressed(LOAD) systemFile("load");
if keyboard_check_pressed(DESTROY) selDestroy();
if keyboard_check_pressed(SUBTRACT) selSubtract();
if mouse_check_button(SWAP)^^swap.now{
	selSwap(keyboard_check(SPLIT),keyboard_check(PEEL));
}