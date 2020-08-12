/// @function selectionSwap(split,peel);
/// @param {boolean} split
/// @param {boolean} peel
function selectionSwap(split,peel){
	if !SwappingItems{
		var selectingsomething=ds_grid_value_exists(SelectionGrid,0,0,COLS,ROWS,1);
		if !selectingsomething exit;
		
		var selx=ds_grid_value_x(SelectionGrid,0,0,COLS,ROWS,1);
		var sely=ds_grid_value_y(SelectionGrid,0,0,COLS,ROWS,1);
		var item=InventoryGrid[#selx,sely];
		if !item exit;
		
		InventoryGrid[#selx,sely]=EMPTY;
		SwappingItems=true;
		SwapList=ds_list_create();
		ds_list_add(SwapList,selx,sely,item);
	}
	else if SwappingItems{
		var x1=ds_list_find_value(SwapList,0);
		var y1=ds_list_find_value(SwapList,1);
		var item=ds_list_find_value(SwapList,2);
		
		// Ensure a slot is being selected
		var selectingsomething=ds_grid_value_exists(SelectionGrid,0,0,COLS,ROWS,1);
		if !selectingsomething InventoryGrid[#x1,y1]=item;
		else{
			// Get coordinates and map of second item
			var x2=ds_grid_value_x(SelectionGrid,0,0,COLS,ROWS,1);
			var y2=ds_grid_value_y(SelectionGrid,0,0,COLS,ROWS,1);
			var destination=InventoryGrid[#x2,y2];
			// Check if destination is EMPTY
			if destination==EMPTY{
				var movewhole=false;
				// If first item is stackable
				if item[?"stackable"]{
					// If start and destination are same
					if x2==x1&&y2==y1 movewhole=true;
					// If start and destination are different
					else{
						// Get amount of first item
						var amount=item[?"amount"];
						// Split first stack in half
						if split{
							var adjusted=floor(amount/2);
							if adjusted{
								var name=item[?"name"];
								var firstitem=ds_map_create();
								ds_map_copy(firstitem,ItemMap[?name]);
								InventoryGrid[#x1,y1]=firstitem;
								InventoryGrid[#x1,y1][?"amount"]=amount-adjusted;
								var seconditem=ds_map_create();
								ds_map_copy(seconditem,ItemMap[?name]);
								InventoryGrid[#x2,y2]=seconditem;
								InventoryGrid[#x2,y2][?"amount"]=adjusted;
							}
							// If first item (adjusted) amount is 0
							else movewhole=true;
						}
						// Peel one from the stack
						else if peel{
							var adjusted=amount-1;
							if adjusted{
								var name=item[?"name"];
								var firstitem=ds_map_create();
								ds_map_copy(firstitem,ItemMap[?name]);
								InventoryGrid[#x1,y1]=firstitem;
								InventoryGrid[#x1,y1][?"amount"]--;
								var seconditem=ds_map_create();
								ds_map_copy(seconditem,ItemMap[?name]);
								InventoryGrid[#x2,y2]=seconditem;
								InventoryGrid[#x1,y1][?"amount"]=adjusted;
							}
							// If first item (adjusted) amount is 0
							else movewhole=true;
						}
						// If not splitting or peeling
						else movewhole=true;
					}
				}
				// If the item isn't stackable
				else movewhole=true;
				// Move item to the destination slot
				if movewhole InventoryGrid[#x2,y2]=item;
			}
			// If destination is not empty
			else{
				// If identical item names and stackable
				if destination[?"name"]==item[?"name"]&&item[?"stackable"]{
					var amount=item[?"amount"];
					// Split first stack and add to second stack
					if split{
						var adjusted=floor(amount/2);
						InventoryGrid[#x1,y1]=item;
						InventoryGrid[#x1,y1][?"amount"]=amount-adjusted;
						if InventoryGrid[#x1,y1][?"amount"]<1 InventoryGrid[#x1,y1]=EMPTY;
						destination[?"amount"]+=adjusted;
					}
					// Peel one off first stack to second stack
					else if peel{
						var adjusted=amount-1;
						InventoryGrid[#x1,y1]=item;
						InventoryGrid[#x1,y1][?"amount"]--;
						if InventoryGrid[#x1,y1][?"amount"]<1 InventoryGrid[#x1,y1]=EMPTY;
						destination[?"amount"]++;
					}
					// Combine stacks
					else{
						destination[?"amount"]+=item[?"amount"];
						InventoryGrid[#x1,y1]=EMPTY;
					}
				}
				// Switch the locations of the items
				else{
					InventoryGrid[#x2,y2]=ds_list_find_value(SwapList,2);
					var x1=ds_list_find_value(SwapList,0);
					var y1=ds_list_find_value(SwapList,1);
					InventoryGrid[#x1,y1]=destination;
				}
			}
		}
		// Cleanup
		ds_list_destroy(SwapList);
		SwappingItems=false;
		exit;
	}
}