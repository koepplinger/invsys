/// @function	selSubtract();
function selSubtract() {
	var sx=ds_grid_value_x(sel,0,0,COLS,ROWS,1);
	var sy=ds_grid_value_y(sel,0,0,COLS,ROWS,1);
	inv[#sx,sy][?"amount"]--;
	if !inv[#sx,sy][?"amount"] inv[#sx,sy]=EMPTY;
}