function swapSelection() {
	if !global.SwappingItems{
		global.SwapList=ds_list_create();
		// get item map from inventory grid
		var swapx=ds_grid_value_x(global.SelectionGrid,0,0,ROWS,COLS,1);
		var swapy=ds_grid_value_y(global.SelectionGrid,0,0,ROWS,COLS,1);
		var swapitem=global.InventoryGrid[#swapx,swapy];
		ds_list_add(global.SwapList,swapx,swapy,swapitem);
	
		// copy map
		global.SwappingItems=true;
		exit;
	}
	if global.SwappingItems{
	
		// Get the second item's (or pointer) x/y/map
		var swap2x=ds_grid_value_x(global.SelectionGrid,0,0,ROWS,COLS,1),
		swap2y=ds_grid_value_y(global.SelectionGrid,0,0,ROWS,COLS,1),
		swap2item=global.InventoryGrid[#swap2x,swap2y];
	
		// Get first item's x, y, map, and width/height
		var swap1x=ds_list_find_value(global.SwapList,0),
		swap1y=ds_list_find_value(global.SwapList,1),
		swap1item=ds_list_find_value(global.SwapList,2),
		width1=swap1item[?"width"],
		height1=swap1item[?"height"];
	
		// Check the region around the second item
		var go=true;
		for (var i=1;i<width1;i++){
			if global.InventoryGrid[#swap2x+i,swap2y]==EMPTY go=true;
			else go=false;
			break;
		}
		for (var i=1;i<height1;i++){
			if !go break;
			if height1+i<ROWS&&global.InventoryGrid[#swap2x,swap2y+i]==EMPTY go=true;
			else go=false;
			break;
		}
	
		// If region is empty, add the item
		if go{
			// Clear the first item from the inventory
			global.InventoryGrid[#swap1x,swap1y]=EMPTY;
			for (var i=1;i<width1;i++){
				global.InventoryGrid[#swap1x+i,swap1y]=EMPTY go=true;
				break;
			}
			for (var i=1;i<height1;i++){
				if !go break;
				global.InventoryGrid[#swap1x,swap1y+i]=EMPTY go=true;
				break;
			}
			// Set pointers in new region
			var pointer=width1;
			pointer=pointer<<8|height1;
			pointer=pointer<<8|swap2x;
			pointer=pointer<<8|swap2y;

			pointer*=-1;
			ds_grid_set_region(global.InventoryGrid,swap2x,swap2y,swap2x+width1-1,swap2y+height1-1,pointer);
			global.InventoryGrid[#swap2x,swap2y]=swap1item;
		ds_list_destroy(global.SwapList);
		global.SwappingItems=false;
			exit;
		}
	
		// check if item1 fits in new spot
		// check if item2 fits in old spot
		// delete items
		// add items in respective slots
	
		// Clean up
		ds_list_destroy(global.SwapList);
		global.SwappingItems=false;
	}


}
