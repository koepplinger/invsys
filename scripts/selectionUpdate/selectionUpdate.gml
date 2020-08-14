/// @function	selectionUpdate();
function selectionUpdate(){
	for (var w=0;w<COLS;w++){
		for (var h=0;h<ROWS;h++){
			var mx=device_mouse_x_to_gui(0);
			var my=device_mouse_y_to_gui(0);
			var xmax=ANCHORX+ICONSIZE*(w+1);
			var ymax=ANCHORY+ICONSIZE*(h+1);
			if mx>ANCHORX&&mx<xmax&&my>ANCHORY&&my<ymax{
				ds_grid_clear(Selection,0);
				Selection[#w,h]=1;
				exit;
			}
			else ds_grid_clear(Selection,0);
		}
	}
}