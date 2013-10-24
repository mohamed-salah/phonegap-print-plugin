var PrintPlugin = {

	print: function(printHTML, successCallback, errorCallback, uri, type, title) {
		if (device.platform == "Android") {
			alert('android');
			cordova.exec(successCallback, errorCallback, "PrintPlugin", "print", [uri, type, title]);
		}
		else
		{
			alert('ios');
			cordova.exec(successCallback, errorCallback, 'PrintPlugin', 'print', [printHTML]);
		}
	},
	isPrintingAvailable: function(successCallback, errorCallback){
		cordova.exec(successCallback, errorCallback, 'PrintPlugin', 'isPrintingAvailable', []);
	}
};

module.exports = PrintPlugin;
