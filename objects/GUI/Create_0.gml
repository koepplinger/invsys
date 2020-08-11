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
global.ItemMap=ds_map_create();
for (var i=0;i<ds_list_size(list);i++){
	var prop=ds_list_find_value(list,i);
	var name=ds_map_find_value(prop,"name");
	ds_map_add(global.ItemMap,name,prop);
}

// CREATE INVENTORY
#macro ANCHORX 0
#macro ANCHORY 0
#macro ICONSIZE 64
#macro COLS 4
#macro ROWS 8
#macro EMPTY -1
//#macro FULL noone
global.InventoryGrid=ds_grid_create(COLS,ROWS);
ds_grid_clear(global.InventoryGrid,EMPTY);

// Selection
global.SelectionGrid=ds_grid_create(COLS,ROWS);
global.SwappingItems=false;