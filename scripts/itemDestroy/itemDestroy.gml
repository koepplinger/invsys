/// @function	itemDestroy(name);
/// @param		{string}	name	The name of the item to destroy
function itemDestroy(name){
	for (var h=0;h<ROWS;++h;){
		for (var w=0;w<COLS;++w;){
			var slot=inv[#w,h];
			if slot!=EMPTY{
				if name==slot[?"name"]{
					if slot[?"stackable"] slot[?"amount"]--;
					else inv[#w,h]=EMPTY;
					exit;
				}
			}
		}
	}
	
}