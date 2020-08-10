function fillArray(argument0) {
	// fillArray("['one','two','three']");

	///jarray(json__list)
	var _map=json_decode(argument0);
	// if the json could not be parsed json_decode returns -1
	if _map==-1{
		show_error("Json could not be read.",false);
	}
	// if it was a _list, the _list is found in "default
	var _list=ds_map_find_value(_map,"default");
	var _length=ds_list_size(_list);
	for (var i=0,_array;i<_length;i++){
	    _array[i]=_list[|i];
	}
	ds_map_destroy(_map);
	ds_list_destroy(_list);
	//show_debug_message("[fillArray]");
	return _array;


}
