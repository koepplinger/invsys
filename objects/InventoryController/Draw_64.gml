// Inventory GUI elements
for (var h=0;h<ROWS;++h;){
	for (var w=0;w<COLS;++w;){
		var item=ds_grid_get(InventoryGrid,w,h)
		if item{
			// Item amount
			var stackable=item[?"stackable"]
			if stackable{
				var amount=item[?"amount"]
				draw_set_color(c_white);
				draw_text(ICONSIZE*w+2,ICONSIZE*h+2,string(amount));
			}
			// Item icon
			var sprite=asset_get_index(item[?"sprite"]);
			draw_sprite(sprite,-1,ICONSIZE*w+ANCHORX,ICONSIZE*h+ANCHORY);
		}
		if ds_grid_value_exists(SelectionGrid,0,0,COLS,ROWS,1){
			var selection=SelectionGrid[#w,h];
			if selection{
				if InventoryGrid[#w,h]>EMPTY{
					// Item selection
					var x1=ANCHORX+ICONSIZE*w;
					var y1=ANCHORY+ICONSIZE*h;
					var x2=x1+ICONSIZE;
					var y2=y1+ICONSIZE;
					draw_set_colour(c_red);
					draw_rectangle(x1,y1,x2,y2,true);
					var selname=InventoryGrid[#w,h];
					var selstring=selname[?"name"];
					// Item inspection
					draw_set_colour(c_white);
					draw_text(0,0,selstring);
				}
			}
		}
	}
}
	
// Swapping 'drag' icon
if SwappingItems{
	var item=ds_list_find_value(SwapList,2);
	var sprite=asset_get_index(item[?"sprite"]);
	var sx=device_mouse_x_to_gui(0)-ICONSIZE/2;
	var sy=device_mouse_y_to_gui(0)-ICONSIZE/2;
	draw_sprite(sprite,0,sx,sy);
}