/// @function	selectionDestroy();
function selectionDestroy() {
	var sx=ds_grid_value_x(SelectionGrid,0,0,COLS,ROWS,1);
	var sy=ds_grid_value_y(SelectionGrid,0,0,COLS,ROWS,1);
	InventoryGrid[#sx,sy]=-1;
}