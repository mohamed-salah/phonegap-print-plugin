Print plugin for Cordova / PhoneGap
======================================================

This Plugin is inspired from [phonegap-print-plugins](https://github.com/collinforrester/PhonegapPrintPlugin) plugin and 

This Plugin brings up a native iOS overlay to print document, this plugin is using [AirPrint](http://en.wikipedia.org/wiki/AirPrint) for iOS and [Google Cloud Print](http://www.google.com/landing/cloudprint/) for android

## Usage

Example Usage: 

```js
var type = "text/html";
var title = "test.html";
var fileContent = "<html>Phonegap Print Plugin</html>";
window.plugins.PrintPlugin.print(fileContent,function(){console.log('success')},function(){console.log('fail')},"",type,title);
```

This has been successfully tested on Cordova 3.0 to 3.1.

## MIT Licence

Copyright 2013 Monday Consulting GmbH

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
