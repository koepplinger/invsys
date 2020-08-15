// inv GUI elements
for (var h=0;h<ROWS;++h;){
	for (var w=0;w<COLS;++w;){
		var item=ds_grid_get(inv,w,h)
		if item{
			// Item amount
			var stackable=item[?"stackable"]
			var ax=ICON*w;
			var ay=ICON*h;
			if stackable{
				var amount=item[?"amount"]
				draw_set_color(c_white);
				draw_text(ax+2,ay+2,string(amount));
			}
			// Item icon
			var sprite=asset_get_index(item[?"sprite"]);
			draw_sprite(sprite,-1,ANCHORX+ax,ANCHORY+ay);
		}
		if ds_grid_value_exists(sel,0,0,COLS,ROWS,1){
			var selection=sel[#w,h];
			if selection&&item{
				// Item selection
				var x1=ANCHORX+ICON*w;
				var y1=ANCHORY+ICON*h;
				var x2=x1+ICON;
				var y2=y1+ICON;
				draw_set_colour(c_red);
				draw_rectangle(x1,y1,x2,y2,true);
				var selname=inv[#w,h];
				var selstring=selname[?"name"];
				// Item inspection
				draw_set_colour(c_white);
				draw_text(0,0,selstring);
			}
		}
	}
}
	
// Swap 'drag' icon
if swap.now{
	var sprite=asset_get_index(swap.map[?"sprite"]);
	var sx=device_mouse_x_to_gui(0)-ICON/2;
	var sy=device_mouse_y_to_gui(0)-ICON/2;
	draw_sprite(sprite,0,sx,sy);
	var stackable=swap.map[?"stackable"]
	if stackable{
		var amount=swap.map[?"amount"]
		draw_set_color(c_white);
		draw_text(sx,sy,string(amount));
	}
}