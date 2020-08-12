// Developer controls
if keyboard_check_pressed(ord("Q")) itemAdd("Katana");
if keyboard_check_pressed(ord("W")) itemAdd("Armor");
if keyboard_check_pressed(ord("E")) itemAdd("Water");

// Main logic loop
selectionUpdate();
if keyboard_check_pressed(vk_escape) game_restart();
if keyboard_check_pressed(vk_f1) systemFile("save");
if keyboard_check_pressed(vk_f2) systemFile("load");
if keyboard_check_pressed(vk_delete) selectionDestroy();
if keyboard_check_pressed(vk_backspace) itemDestroy("Katana");
if mouse_check_button(mb_left)^^SwappingItems{
	var split=keyboard_check(vk_shift);
	var peel=keyboard_check(vk_control);
	selectionSwap(split,peel);
}