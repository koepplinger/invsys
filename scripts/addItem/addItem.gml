/// @function	addItem(itemname);
/// @param		{string}	item	The name of the item to add

function addItem(item){
	// Add one to an existing item's amount
	if global.ItemMap[?item][?"stackable"]{
		for (var h=0;h<ROWS;++h;){
			for (var w=0;w<COLS;++w;){
				var slot=global.InventoryGrid[#w,h];
				if slot!=EMPTY{
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
	var space=ds_grid_value_exists(global.InventoryGrid,0,0,COLS,ROWS,EMPTY);
	if !space exit;
	var copy=ds_map_create();
	ds_map_copy(copy,global.ItemMap[?item]);
	for (var h=0;h<ROWS;++h;){
		for (var w=0;w<COLS;++w;){
			var slot=global.InventoryGrid[#w,h];
			if slot==EMPTY{
				global.InventoryGrid[#w,h]=copy;
				exit;
			}
		}
	}
}