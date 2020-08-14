/// @function	selectionDestroy();
function selectionDestroy() {
	var sx=ds_grid_value_x(Selection,0,0,COLS,ROWS,1);
	var sy=ds_grid_value_y(Selection,0,0,COLS,ROWS,1);
	Inventory[#sx,sy]=-1;
}