// Icon, selection, inspection
for (var h=0;h<ROWS;++h;){
	for (var w=0;w<COLS;++w;){
		var item=ds_grid_get(global.InventoryGrid,w,h)
		if item{
			var stackable=item[?"stackable"]
			if stackable{
				var amount=item[?"amount"]
				draw_set_color(c_white);
				draw_text(ICONSIZE*w+2,ICONSIZE*h+2,string(amount));
			}
			draw_sprite(asset_get_index(item[?"sprite"]),-1,ICONSIZE*w+ANCHORX,ICONSIZE*h+ANCHORY);
		}
		if ds_grid_value_exists(global.SelectionGrid,0,0,COLS,ROWS,1){
			var selection=global.SelectionGrid[#w,h];
			if selection{
				if global.InventoryGrid[#w,h]>EMPTY{
					var x1=ANCHORX+ICONSIZE*w,
					y1=ANCHORY+ICONSIZE*h,
					x2=x1+ICONSIZE,
					y2=y1+ICONSIZE;
					draw_set_colour(c_red);
					draw_rectangle(x1,y1,x2,y2,true);
					var selname=global.InventoryGrid[#w,h],selstring=selname[?"name"];
					draw_set_colour(c_white);
					draw_text(0,0,selstring);
				}
			}
		}
	}
}
	
// Swapping 'drag' icon
if global.SwappingItems{
	var item=ds_list_find_value(global.swap,2),sprite=asset_get_index(item[?"sprite"]);
	draw_sprite(sprite,0,device_mouse_x_to_gui(0)-ICONSIZE/2,device_mouse_y_to_gui(0)-ICONSIZE/2);
}