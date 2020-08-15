/// @function	itemAdd(item);
/// @param		{string}	item	The name of the item to add
function itemAdd(item){
	// Add one to an existing item's amount
	if items[?item][?"stackable"]{
		for (var h=0;h<ROWS;++h;){
			for (var w=0;w<COLS;++w;){
				var slot=inv[#w,h];
				if slot{
					var existing=slot[?"name"];
					if item==existing{
						slot[?"amount"]++;
						exit;
					}
				}
			}
		}
	}
	// Add item to first empty slot
	var space=ds_grid_value_exists(inv,0,0,COLS,ROWS,EMPTY);
	if !space exit;
	var copy=ds_map_create();
	ds_map_copy(copy,items[?item]);
	for (var h=0;h<ROWS;++h;){
		for (var w=0;w<COLS;++w;){
			var slot=inv[#w,h];
			if slot==EMPTY{
				inv[#w,h]=copy;
				exit;
			}
		}
	}
	//show_debug_message("inv full");
}