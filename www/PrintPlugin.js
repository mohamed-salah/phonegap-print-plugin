var PrintPlugin = {

	print: function(printHTML, successCallback, errorCallback, uri, type, title) {
		if (device.platform == "Android") {
			cordova.exec(successCallback, errorCallback, "PrintPlugin", "print", [uri, type, title]);
		}
		else
		{
			cordova.exec(successCallback, errorCallback, 'PrintPlugin', 'print', [printHTML]);
		}
	},
	isPrintingAvailable: function(successCallback, errorCallback){
		cordova.exec(successCallback, errorCallback, 'PrintPlugin', 'isPrintingAvailable', []);
	}
};

module.exports = PrintPlugin;
