/**
 * @constructor
 */
var PrintPlugin = function () {};

PrintPlugin.prototype.print = function (printHTML, successCallback, errorCallback, uri, type, title) {

    if (!(printHTML instanceof Array)) {
        printHTML = [printHTML];
    }

    if (device.platform == "Android") {

        printHTML = printHTML[0].replace(/(\r\n|\n|\r)/gm, "");
        var code = 'javascript:printDialog.setPrintDocument(printDialog.createPrintDocument("' + type + '", "' + title + '", "' + printHTML + '"))';
        var ref = window.open('https://www.google.com/cloudprint/dialog.html', '_blank', 'location=yes');
        ref.addEventListener('loadstop', function (event) {
            //wait 1 second till printDialog object is initialized
            setTimeout(function () {
                ref.executeScript({
                    code: code,
                }, function () {
                    console.log('document assigned successfully to google cloud print dialog');
                    successCallback();
                });
            }, 1000);

        });
    } else {
        cordova.exec(successCallback, errorCallback, 'PrintPlugin', 'print', printHTML);
    }
};

PrintPlugin.prototype.isPrintingAvailable = function (successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'PrintPlugin', 'isPrintingAvailable', []);
};

// Plug in to Cordova
cordova.addConstructor(function () {

    if (!window.Cordova) {
        window.Cordova = cordova;
    };

    if (!window.plugins) window.plugins = {};
    window.plugins.PrintPlugin = new PrintPlugin();
});
