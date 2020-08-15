// IMPORT JSON
var file=file_text_open_read("items.json");
var line=""; 
while !file_text_eof(file){
	line+=file_text_read_string(file);
	file_text_readln(file);
}
file_text_close(file);
var map=json_decode(line);
var list=ds_map_find_value(map,"default");
items=ds_map_create();
for (var i=0;i<ds_list_size(list);i++){
	var prop=ds_list_find_value(list,i);
	var key=ds_map_find_value(prop,"name");
	ds_map_add(items,key,prop);
}

// KEYBIND SETUP
#macro QUIT vk_escape
#macro SAVE vk_f1
#macro LOAD vk_f2
#macro DESTROY vk_delete
#macro SUBTRACT vk_subtract
#macro DESTROYKATANA vk_backspace
#macro SWAP mb_left
#macro SPLIT vk_shift
#macro PEEL vk_control

// INVENTORY SETUP
#macro SAVEFILE "save.ini"
#macro ANCHORX 0
#macro ANCHORY 0
#macro ICON 64
#macro COLS 4
#macro ROWS 8
#macro EMPTY -1
#macro CURRENT 1
inv=ds_grid_create(COLS,ROWS);
ds_grid_clear(inv,EMPTY);

// SELECTION SETUP
sel=ds_grid_create(COLS,ROWS);
swap={now: false};