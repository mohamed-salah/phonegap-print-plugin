var PrintPlugin = {

	print: function(success, fail, uri, type, title) {
		cordova.exec(success, fail, "PrintPlugin", "print", [uri, type, title]);
	}
};

module.exports = PrintPlugin;
