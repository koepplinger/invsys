var invgrid=global.InventoryGrid,
selgrid=global.SelectionGrid;

// Sprite icons & stack amounts
for (var h=0;h<ROWS;++h;){
	for (var w=0;w<COLS;++w;){
		var this=ds_grid_get(invgrid,w,h)
		if this>EMPTY{
			var sprite=asset_get_index(this[?"sprite"]);
			draw_sprite(sprite,-1,ICONSIZE*w+ANCHORX,ICONSIZE*h+ANCHORY);
			var stackable=this[?"stackable"]
			if stackable{
				var amount=this[?"amount"]
				draw_text_color(ICONSIZE*w+2,ICONSIZE*h+2,string(amount),c_white,c_white,c_white,c_white,100);
			}
		}
	}
}

// Selection & inspection
if ds_grid_value_exists(global.SelectionGrid,0,0,COLS,ROWS,1){
	draw_set_colour(c_red);
	for (var h=0;h<ROWS;++h;){
		for (var w=0;w<COLS;++w;){
		
			// Check if this slot is selected
			var this=selgrid[#w,h];
			if this{
			
				// If directly selecting an item
				if invgrid[#w,h]>EMPTY{
				
					// Draw selection box
					var x1=ANCHORX+ICONSIZE*w,
					y1=ANCHORY+ICONSIZE*h,
					x2=x1+ICONSIZE,
					y2=y1+ICONSIZE;
					draw_rectangle(x1,y1,x2,y2,true);
				
					// Draw inspection
					var selname=invgrid[#w,h],selstring=selname[?"name"];
					draw_text_color(0,0,selstring,c_white,c_white,c_white,c_white,1);
				}
			}
		}
	}
}