function validateField(formName, fieldName, importance) {
	if (importance == "required") {
	} else if (importance == "unique") {
	}
}
var callbacks = {
	list : {},
	register : function(id, code) {
		this.list[id] = code;
	},
	get : function(id) {
		return this.list[id];
	}
}
