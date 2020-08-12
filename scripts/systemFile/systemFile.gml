/// @function systemFile(command);
/// @param {string} command The desired command
function systemFile(command){
	ini_open(SAVEFILE);
	var section="items";
	var key="inventory";
	if command=="save"{
		ini_write_string(section,key,ds_grid_write(InventoryGrid));
	}
	if command=="load"&&ini_section_exists(section){
		ds_grid_read(InventoryGrid,ini_read_string(section,key,""));
	}
	ini_close();
}