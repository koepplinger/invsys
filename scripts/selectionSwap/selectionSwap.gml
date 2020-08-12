/// @function selectionSwap(split,peel);
/// @param {boolean} split
/// @param {boolean} peel
function selectionSwap(split,peel){
	// Begin swap
	if !SwappingItems{
		// Ensure a slot is being selected
		var selecting=ds_grid_value_exists(SelectionGrid,0,0,COLS,ROWS,1);
		if !selecting exit;
		// Get the item being selected
		var sx=ds_grid_value_x(SelectionGrid,0,0,COLS,ROWS,1);
		var sy=ds_grid_value_y(SelectionGrid,0,0,COLS,ROWS,1);
		var item=InventoryGrid[#sx,sy];
		// Ensure an item is selected
		if !item exit;
		// Indicate swapping state
		SwappingItems=true;
		// Remove item
		InventoryGrid[#sx,sy]=EMPTY;
		// Create swap list
		SwapList=ds_list_create();
		ds_list_add(SwapList,sx,sy,item);
	}
	// Finish swap
	else if SwappingItems{
		// Pull original item's values from list
		var sx=ds_list_find_value(SwapList,0);
		var sy=ds_list_find_value(SwapList,1);
		var item=ds_list_find_value(SwapList,2);
		// Ensure a slot is being selected
		var selecting=ds_grid_value_exists(SelectionGrid,0,0,COLS,ROWS,1);
		// If a slot isn't being selected return item to its original place
		if !selecting InventoryGrid[#sx,sy]=item;
		// If a slot is being selected
		else{
			// Get selected item
			var dx=ds_grid_value_x(SelectionGrid,0,0,COLS,ROWS,1);
			var dy=ds_grid_value_y(SelectionGrid,0,0,COLS,ROWS,1);
			var destination=InventoryGrid[#dx,dy];
			// Check if destination is EMPTY
			if destination==EMPTY{
				var replace=false;
				// If item is stackable and SHIFT is held, split the stack
				if item[?"stackable"]{
					if dx==sx&&dy==sy replace=true;
					else{
						var amount=item[?"amount"];
						if split{
							var adjusted=floor(amount/2);
							if adjusted>0{
								var name=item[?"name"];
								var firstitem=ds_map_create();
								ds_map_copy(firstitem,ItemMap[?name]);
								InventoryGrid[#sx,sy]=firstitem;
								InventoryGrid[#sx,sy][?"amount"]=amount-adjusted;
								var seconditem=ds_map_create();
								ds_map_copy(seconditem,ItemMap[?name]);
								InventoryGrid[#dx,dy]=seconditem;
								InventoryGrid[#dx,dy][?"amount"]=adjusted;
							}
							else replace=true;
						}
						else if peel{
							var adjusted=amount-1;
							if adjusted>0{
								var name=item[?"name"];
								var firstitem=ds_map_create();
								ds_map_copy(firstitem,ItemMap[?name]);
								InventoryGrid[#sx,sy]=firstitem;
								InventoryGrid[#sx,sy][?"amount"]--;
								var seconditem=ds_map_create();
								ds_map_copy(seconditem,ItemMap[?name]);
								InventoryGrid[#dx,dy]=seconditem;
								InventoryGrid[#sx,sy][?"amount"]=adjusted;
							}
							else replace=true;
						}
						else replace=true;
					}
				}
				else replace=true;
				if replace InventoryGrid[#dx,dy]=item;
			}
			// If destination is not empty
			else{
				// If both items are the same and stackable
				if destination[?"name"]==item[?"name"]&&item[?"stackable"]{
					var amount=item[?"amount"];
					if split{
						var adjusted=floor(amount/2);
						InventoryGrid[#sx,sy]=item;
						InventoryGrid[#sx,sy][?"amount"]=amount-adjusted;
						if InventoryGrid[#sx,sy][?"amount"]<1 InventoryGrid[#sx,sy]=EMPTY;
						destination[?"amount"]+=adjusted;
					}
					else if peel{
						var adjusted=amount-1;
						InventoryGrid[#sx,sy]=item;
						InventoryGrid[#sx,sy][?"amount"]--;
						if InventoryGrid[#sx,sy][?"amount"]<1 InventoryGrid[#sx,sy]=EMPTY;
						destination[?"amount"]++;
					}
					// Combine stacks
					else{
						destination[?"amount"]+=item[?"amount"];
						InventoryGrid[#sx,sy]=EMPTY;
					}
				}
				else{
					// Switch the locations of the items
					InventoryGrid[#dx,dy]=ds_list_find_value(SwapList,2);
					var sx=ds_list_find_value(SwapList,0);
					var sy=ds_list_find_value(SwapList,1);
					InventoryGrid[#sx,sy]=destination;
				}
			}
		}
		ds_list_destroy(SwapList);
		SwappingItems=false;
		exit;
	}
}
