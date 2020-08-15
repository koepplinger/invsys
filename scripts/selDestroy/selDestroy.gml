/// @function	selDestroy();
function selDestroy(){
	var sx=ds_grid_value_x(sel,0,0,COLS,ROWS,1);
	var sy=ds_grid_value_y(sel,0,0,COLS,ROWS,1);
	inv[#sx,sy]=-1;
}