/// @function selectionSwap(split,peel);
/// @param {boolean} split
/// @param {boolean} peel
function selectionSwap(split,peel){
	if !Swapping{
		var selectingsomething=ds_grid_value_exists(Selection,0,0,COLS,ROWS,1);
		if !selectingsomething exit;
		
		var selx=ds_grid_value_x(Selection,0,0,COLS,ROWS,1);
		var sely=ds_grid_value_y(Selection,0,0,COLS,ROWS,1);
		var item=Inventory[#selx,sely];
		if !item exit;
		
		Inventory[#selx,sely]=EMPTY;
		Swapping=true;
		SwapList=ds_list_create();
		ds_list_add(SwapList,selx,sely,item);
	}
	else if Swapping{
		// Get coordinates and map of the first item
		var x1=ds_list_find_value(SwapList,0);
		var y1=ds_list_find_value(SwapList,1);
		var item1=ds_list_find_value(SwapList,2);
		
		// Ensure a slot is being selected
		var selectingsomething=ds_grid_value_exists(Selection,0,0,COLS,ROWS,1);
		if !selectingsomething Inventory[#x1,y1]=item1;
		else{
			// Get coordinates and map of second item
			var x2=ds_grid_value_x(Selection,0,0,COLS,ROWS,1);
			var y2=ds_grid_value_y(Selection,0,0,COLS,ROWS,1);
			var item2=Inventory[#x2,y2];
			
			// Check if destination is EMPTY
			if item2==EMPTY{
				var movewhole=false;
				
				// If first item is stackable
				if item1[?"stackable"]{
					
					// Move whole item if destination is same as start
					if x2==x1&&y2==y1 movewhole=true;
					
					// If start and destination are different
					else{
						// Get amount of first item
						var amount=item1[?"amount"];
						
						// Split first stack in half
						if split{
							var adjusted=floor(amount/2);
							if adjusted{
								var name=item1[?"name"];
								var item1copy=ds_map_create();
								ds_map_copy(item1copy,ItemMap[?name]);
								Inventory[#x1,y1]=item1copy;
								Inventory[#x1,y1][?"amount"]=amount-adjusted;
								var item2copy=ds_map_create();
								ds_map_copy(item2copy,ItemMap[?name]);
								Inventory[#x2,y2]=item2copy;
								Inventory[#x2,y2][?"amount"]=adjusted;
							}
							// If first item (adjusted) amount is 0
							else movewhole=true;
						}
						// Peel one from the stack
						else if peel{
							var adjusted=amount-1;
							if adjusted{
								var name=item1[?"name"];
								var item1copy=ds_map_create();
								ds_map_copy(item1copy,ItemMap[?name]);
								Inventory[#x1,y1]=item1copy;
								Inventory[#x1,y1][?"amount"]--;
								var item2copy=ds_map_create();
								ds_map_copy(item2copy,ItemMap[?name]);
								Inventory[#x2,y2]=item2copy;
								Inventory[#x1,y1][?"amount"]=adjusted;
							}
							// If first item (adjusted) amount is 0
							else movewhole=true;
						}
						// If not splitting nor peeling
						else movewhole=true;
					}
				}
				// If the item isn't stackable
				else movewhole=true;
				
				// Move item to the item2 slot
				if movewhole Inventory[#x2,y2]=item1;
			}
			// If item2 is not empty
			else{
				// If item names are identical and stackable
				if item2[?"name"]==item1[?"name"]&&item1[?"stackable"]{
					var amount=item1[?"amount"];
					
					// Split first stack and add to second stack
					if split{
						var adjusted=floor(amount/2);
						Inventory[#x1,y1]=item1;
						Inventory[#x1,y1][?"amount"]=amount-adjusted;
						if Inventory[#x1,y1][?"amount"]<1 Inventory[#x1,y1]=EMPTY;
						item2[?"amount"]+=adjusted;
					}
					// Peel one off first stack to second stack
					else if peel{
						var adjusted=amount-1;
						Inventory[#x1,y1]=item1;
						Inventory[#x1,y1][?"amount"]--;
						if Inventory[#x1,y1][?"amount"]<1 Inventory[#x1,y1]=EMPTY;
						item2[?"amount"]++;
					}
					// Combine stacks
					else{
						item2[?"amount"]+=item1[?"amount"];
						Inventory[#x1,y1]=EMPTY;
					}
				}
				// Switch the locations of the items
				else{
					Inventory[#x2,y2]=ds_list_find_value(SwapList,2);
					var x1=ds_list_find_value(SwapList,0);
					var y1=ds_list_find_value(SwapList,1);
					Inventory[#x1,y1]=item2;
				}
			}
		}
		// Cleanup
		ds_list_destroy(SwapList);
		Swapping=false;
		exit;
	}
}