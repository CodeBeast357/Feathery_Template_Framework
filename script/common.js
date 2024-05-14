// AJAX Functions
function newRequest(){
	var request;
	if(window.XMLHttpRequest){
		//Firefox or IE >= 7.0
		request = new XMLHttpRequest();
	}else if(window.ActiveXObject){
		try{ // another try for IE
			request = new ActiveXObject("Msxml2.XMLHTTP");
		}catch(e){
			try{ // yet another for IE
				request = new ActiveXObject("Microsoft.XMLHTTP");
			}catch(e){
				alert("Unable to create request.");
			}
		}
	}
	return request;
}
function sendRequest(ressource, method, parser, parameters){
	try{
		var server = newRequest();
		server.open(method, ressource, true);
		if (parameters)
			server.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		else
			server.setRequestHeader("Content-Type", "text/plain");
		server.onreadystatechange = function(){parser(server)};
		server.send(parameters);
	}catch(e){
		alert("Impossible to connect to server. " + e);
	}
}
function sendSimpleRequest(ressource, method, textParser, parameters){
	generalParser = function(server){
		if(server.readyState == 4 && server.status == 200){
			textParser(server.responseText);
		}
	}
	sendRequest(ressource, method, generalParser, parameters);
}
function sendSimpleXMLRequest(ressource, method, XMLparser, parameters){
	generalParser = function(server){
		if(server.readyState == 4 && server.status == 200){
			XMLparser(server.responseXML);
		}
	}
	sendRequest(ressource, method, generalParser, parameters);
}
function sendSimpleForm(ressource, method, parser, form){
	var parameters = "";
	for (n = 0; n < form.elements.length; n++){
		var input = form.elements[n];
		if (input.name != "")
			parameters += input.name + "=" + input.value + "&";
	}
	if (parameters.length > 0)
		parameters = parameters.slice(0, parameters.length - 1);
	sendSimpleRequest(ressource, method, parser, parameters);
}
function sendSimpleXMLForm(ressource, method, XMLparser, form){
	var parameters = "";
	for (n = 0; n < form.elements.length; n++){
		var input = form.elements[n];
		if (input.name != "")
			parameters += input.name + "=" + input.value + "&";
	}
	if (parameters.length > 0)
		parameters = parameters.slice(0, parameters.length - 1);
	sendSimpleXMLRequest(ressource, method, XMLparser, parameters);
}
// XML Functions
var xmlParser = {
	defaultXSLstylesheet : "http://localhost/Feathery Template Framework/struct/default.xsl",
	init : function() {
		try { //Internet Explorer
			this.XSLstylesheet = new ActiveXObject("Microsoft.XMLDOM");
		} catch(e) {
			try { //Firefox, Mozilla, Opera, etc.
				this.XSLstylesheet = document.implementation.createDocument("", "", null);
			} catch(e) {
				alert("XSL not implemented.\nException: " + e);
			}
		}
		this.XSLstylesheet.async = false;
		this.XSLparser = new XSLTProcessor();
	},
	parse : function(xmlNode, xslFilepath) {
		if (!this.XSLstylesheet || !this.XSLparser) {
			this.init();
		}
		this.XSLstylesheet.load(xslFilepath || this.defaultXSLstylesheet);
		this.XSLparser.importStylesheet(this.XSLstylesheet);
		return this.XSLparser.transformToDocument(xmlNode);
	}
}
// 