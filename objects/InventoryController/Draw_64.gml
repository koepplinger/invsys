// Inventory GUI elements
for (var h=0;h<ROWS;++h;){
	for (var w=0;w<COLS;++w;){
		var item=ds_grid_get(Inventory,w,h)
		if item{
			// Item amount
			var stackable=item[?"stackable"]
			var ax=ICONSIZE*w;
			var ay=ICONSIZE*h;
			if stackable{
				var amount=item[?"amount"]
				draw_set_color(c_white);
				draw_text(ax+2,ay+2,string(amount));
			}
			// Item icon
			var sprite=asset_get_index(item[?"sprite"]);
			draw_sprite(sprite,-1,ANCHORX+ax,ANCHORY+ay);
		}
		if ds_grid_value_exists(Selection,0,0,COLS,ROWS,1){
			var selection=Selection[#w,h];
			if selection&&item{
				// Item selection
				var x1=ANCHORX+ICONSIZE*w;
				var y1=ANCHORY+ICONSIZE*h;
				var x2=x1+ICONSIZE;
				var y2=y1+ICONSIZE;
				draw_set_colour(c_red);
				draw_rectangle(x1,y1,x2,y2,true);
				var selname=Inventory[#w,h];
				var selstring=selname[?"name"];
				// Item inspection
				draw_set_colour(c_white);
				draw_text(0,0,selstring);
			}
		}
	}
}
	
// Swapping 'drag' icon
if Swapping{
	var item=ds_list_find_value(SwapList,2);
	var sprite=asset_get_index(item[?"sprite"]);
	var sx=device_mouse_x_to_gui(0)-ICONSIZE/2;
	var sy=device_mouse_y_to_gui(0)-ICONSIZE/2;
	draw_sprite(sprite,0,sx,sy);
	var stackable=item[?"stackable"]
	if stackable{
		var amount=item[?"amount"]
		draw_set_color(c_white);
		draw_text(sx,sy,string(amount));
	}
}