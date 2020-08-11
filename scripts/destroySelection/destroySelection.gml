function destroySelection() {
	var selx=ds_grid_value_x(global.SelectionGrid,0,0,COLS,ROWS,1);
	var sely=ds_grid_value_y(global.SelectionGrid,0,0,COLS,ROWS,1);
	global.InventoryGrid[#selx,sely]=-1;
}