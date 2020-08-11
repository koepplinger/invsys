/// @function swapSelection(split,peel);
/// @param {boolean} split
/// @param {boolean} peel

function swapSelection(split,peel){
	// Begin swap
	if !global.SwappingItems{
		// Ensure a slot is being selected
		var selecting=ds_grid_value_exists(global.SelectionGrid,0,0,COLS,ROWS,1);
		if !selecting exit;
		// Get the item being selected
		var sx=ds_grid_value_x(global.SelectionGrid,0,0,COLS,ROWS,1);
		var sy=ds_grid_value_y(global.SelectionGrid,0,0,COLS,ROWS,1);
		var item=global.InventoryGrid[#sx,sy];
		// Ensure an item is selected
		if !item exit;
		// Indicate swapping state
		global.SwappingItems=true;
		// Remove item
		global.InventoryGrid[#sx,sy]=EMPTY;
		// Create swap list
		global.swap=ds_list_create();
		ds_list_add(global.swap,sx,sy,item);
	}
	// Finish swap
	else if global.SwappingItems{
		// Pull original item's values from list
		var sx=ds_list_find_value(global.swap,0);
		var sy=ds_list_find_value(global.swap,1);
		var item=ds_list_find_value(global.swap,2);
		// Ensure a slot is being selected
		var selecting=ds_grid_value_exists(global.SelectionGrid,0,0,COLS,ROWS,1);
		// If a slot isn't being selected
		if !selecting{
			// Return item to its original place
			global.InventoryGrid[#sx,sy]=item;
		}
		// If a slot is being selected
		else{
			// Get selected item
			var dx=ds_grid_value_x(global.SelectionGrid,0,0,COLS,ROWS,1);
			var dy=ds_grid_value_y(global.SelectionGrid,0,0,COLS,ROWS,1);
			var destination=global.InventoryGrid[#dx,dy];
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
								var newitem=ds_map_create();
								ds_map_copy(newitem,global.ItemMap[?name]);
								global.InventoryGrid[#sx,sy]=newitem;
								global.InventoryGrid[#sx,sy][?"amount"]=amount-adjusted;
								var newitem2=ds_map_create();
								ds_map_copy(newitem2,global.ItemMap[?name]);
								global.InventoryGrid[#dx,dy]=newitem2;
								global.InventoryGrid[#dx,dy][?"amount"]=adjusted;
							}
							else replace=true;
						}
						else if peel{
							var adjusted=amount-1;
							if adjusted>0{
								var name=item[?"name"];
								var newitem=ds_map_create();
								ds_map_copy(newitem,global.ItemMap[?name]);
								global.InventoryGrid[#sx,sy]=newitem;
								global.InventoryGrid[#sx,sy][?"amount"]--;
								var newitem2=ds_map_create();
								ds_map_copy(newitem2,global.ItemMap[?name]);
								global.InventoryGrid[#dx,dy]=newitem2;
								global.InventoryGrid[#sx,sy][?"amount"]=adjusted;
							}
							else replace=true;
						}
						else replace=true;
					}
				}
				else replace=true;
				if replace global.InventoryGrid[#dx,dy]=item;
			}
			// If destination is not empty
			else{
				// If both items are the same and stackable
				if destination[?"name"]==item[?"name"]&&item[?"stackable"]{
					var amount=item[?"amount"];
					if split{
						var adjusted=floor(amount/2);
						global.InventoryGrid[#sx,sy]=item;
						global.InventoryGrid[#sx,sy][?"amount"]=amount-adjusted;
						if global.InventoryGrid[#sx,sy][?"amount"]<1 global.InventoryGrid[#sx,sy]=EMPTY;
						destination[?"amount"]+=adjusted;
					}
					else if peel{
						var adjusted=amount-1;
						global.InventoryGrid[#sx,sy]=item;
						global.InventoryGrid[#sx,sy][?"amount"]--;
						if global.InventoryGrid[#sx,sy][?"amount"]<1 global.InventoryGrid[#sx,sy]=EMPTY;
						destination[?"amount"]++;
					}
					// Combine stacks
					else{
						destination[?"amount"]+=item[?"amount"];
						global.InventoryGrid[#sx,sy]=EMPTY;
					}
				}
				else{
					// Switch the locations of the items
					global.InventoryGrid[#dx,dy]=ds_list_find_value(global.swap,2);
					var sx=ds_list_find_value(global.swap,0);
					var sy=ds_list_find_value(global.swap,1);
					global.InventoryGrid[#sx,sy]=destination;
				}
			}
		}
		ds_list_destroy(global.swap);
		global.SwappingItems=false;
		exit;
	}
}
