// Index Functions
var index_controls = {
	init : function() {
		/*document.getElementById("index-content").standardRight = document.getElementById("index-content").style.right;
		document.getElementById("index-content").hidingRight = "95%";
		document.getElementById("body-header").standardLeft = document.getElementById("body-header").style.left;
		document.getElementById("body-header").hidingLeft = "5%";
		document.getElementById("body-content").standardLeft = document.getElementById("body-content").style.left;
		document.getElementById("body-content").hidingLeft = "5%";
		document.getElementById("body-content").standardWidth = document.getElementById("body-content").style.width;
		document.getElementById("body-content").hidingWidth = "95%";*/
		// Defining targets
		this.indexContent = document.getElementById("index-content");
		this.bodyHeader = document.getElementById("body-header");
		this.bodyContent = document.getElementById("body-content");
		// Registering index functions calls
		var index_hider = document.getElementById("index-hider");
		index_hider.href = "javascript:index_controls.hide();";
		var index_shower = document.getElementById("index-shower");
		index_shower.href = "javascript:index_controls.show();";
	},
	hide : function() {
		document.getElementById("index-value").style.display = "none";
		/*document.getElementById("index-content").style.right = document.getElementById("index-content").hidingRight;
		document.getElementById("body-header").style.left = document.getElementById("body-header").hidingLeft;
		document.getElementById("body-content").style.left = document.getElementById("body-content").hidingLeft;
		document.getElementById("body-content").style.width = document.getElementById("body-content").hidingWidth;*/
		this.indexContent.className = "hide";
		this.bodyHeader.className = "hide";
		this.bodyContent.className = "hide";
	},
	show : function() {
		document.getElementById("index-value").style.display = "block";
		/*document.getElementById("index-content").style.right = document.getElementById("index-content").standardRight;
		document.getElementById("body-header").style.left = document.getElementById("body-header").standardLeft;
		document.getElementById("body-content").style.left = document.getElementById("body-content").standardLeft;
		document.getElementById("body-content").style.width = document.getElementById("body-content").standardWidth;*/
		this.indexContent.className = "show";
		this.bodyHeader.className = "show";
		this.bodyContent.className = "show";
	}
}
// Initialization
function init() {
	// Initialization of index controls
	index_controls.init();
}
window.onload = init;
