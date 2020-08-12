/// @function	itemDestroy(item);
/// @param		{string}	item	The name of the item to destroy
function itemDestroy(item){
	for (var h=0;h<ROWS;++h;){
		for (var w=0;w<COLS;++w;){
			var slot=InventoryGrid[#w,h];
			if slot!=EMPTY{
				if item==slot[?"name"]{
					if slot[?"stackable"]{
						slot[?"amount"]--;
						exit;
					}
					else{
						InventoryGrid[#w,h]=EMPTY;
						exit;
					}
				}
			}
		}
	}
	
}