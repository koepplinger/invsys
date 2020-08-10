/// @function	addItem(itemname);
/// @param		{string}	itemname	The name of the item to add

function addItem(itemname) {
	
	// Get base item
	var item=global.ItemMap[?itemname];
	
	// Check if stackable item already held
	if item[?"stackable"]{
		// Search y
		for (var h=0;h<ROWS;++h;){
			// Search x
			for (var w=0;w<COLS;++w;){
				// If this grid node isn't empty
				if global.InventoryGrid[#w,h]!=EMPTY{
					// Get the map of the item in this node
					var nodename=global.InventoryGrid[#w,h][?"name"];
					// If the item to add has the same name
					if itemname==nodename{
						// Increase the amount
						global.InventoryGrid[#w,h][?"amount"]++;
						exit;
					}
				}
			}
		}
	}

	// Ensure an empty slot exists
	var space=ds_grid_value_exists(global.InventoryGrid,0,0,COLS,ROWS,EMPTY);
	if !space exit;

	// Copy the item's base map
	var neww=ds_map_create();
	ds_map_copy(neww,item);

	// Look through inventory for the first empty slot
	for (var h=0;h<ROWS;++h;){
		for (var w=0;w<COLS;++w;){
			var slot=global.InventoryGrid[#w,h]//ds_grid_value_exists(global.InventoryGrid,w,h,w,h,EMPTY);
			if slot==EMPTY{
				global.InventoryGrid[#w,h]=neww;
				exit;
			}
		}
	}


}