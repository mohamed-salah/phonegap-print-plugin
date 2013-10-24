package com.phonegap.plugins;

import java.io.File;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import android.content.Intent;
import android.net.Uri;

/**
 * The Class MacAddressPlugin.
 */
public class PrintPlugin extends CordovaPlugin {

	@Override
	public boolean execute(String action, JSONArray args,
			CallbackContext callbackContext) throws JSONException {
		if (action.equals("print")) {
			String uri = args.getString(0);
			String type = args.getString(1);
			String title = args.getString(2);
			Intent printIntent = new Intent(this.cordova.getActivity(),
					PrintDialogActivity.class);
			printIntent.setDataAndType(
					Uri.fromFile(new File(uri)),
					type);
			printIntent.putExtra("title", title);
			cordova.startActivityForResult(this, printIntent, 1);
			return true;
		}
		return false;
	}

}
