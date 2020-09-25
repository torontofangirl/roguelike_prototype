function script_execute_array(_script, _args){
	switch (array_length(_args)) {
 
		case 1: return script_execute(_script, _args[0]);
 
		case 2: return script_execute(_script, _args[0], _args[1]);
 
		case 3: return script_execute(_script, _args[0], _args[1], _args[2]);
 
		case 4: return script_execute(_script, _args[0], _args[1], _args[2], _args[3]);
 
		case 5: return script_execute(_script, _args[0], _args[1], _args[2], _args[3], _args[4]);
 
		case 6: return script_execute(_script, _args[0], _args[1], _args[2], _args[3], _args[4], _args[5]);
 
		case 7: return script_execute(_script, _args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6]);
 
		case 8: return script_execute(_script, _args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6], _args[7]);
 
		default: show_error("script_execute_array: argument count not supported!", false);
	}
}

function approach(_a, _b, _amount){
	//moves a towards b by amount
	//will not overshoot b
	if (_a < _b){
		_a += _amount
		if (_a > _b)
			return _b
	}
	else{
		_a -= _amount
		if (_a < _b)
			return _b
	}
	return _a
}

function chance(_percent){
	//chance(0.7) returns true 70% of time
	return _percent > random(1)
}

