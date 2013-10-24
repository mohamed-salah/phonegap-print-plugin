package com.phonegap.plugins;

import java.io.File;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;

import android.content.Intent;
import android.net.Uri;

/**
 * The Class MacAddressPlugin.
 */
public class PrintPlugin extends CordovaPlugin {
	private CallbackContext callbackContext;

	@Override
	public boolean execute(String action, JSONArray args,
			CallbackContext callbackContext) throws JSONException {
		this.callbackContext = callbackContext;
		if (action.equals("print")) {
			String uri = args.getString(0);
			String type = args.getString(1);
			String title = args.getString(2);
			Intent printIntent = new Intent(this.cordova.getActivity(),
					PrintDialogActivity.class);
			printIntent.setDataAndType(Uri.fromFile(new File(uri)), type);
			printIntent.putExtra("title", title);
			this.cordova.startActivityForResult(this, printIntent, 1);
			PluginResult r = new PluginResult(PluginResult.Status.NO_RESULT);
			r.setKeepCallback(true);
			callbackContext.sendPluginResult(r);
			return true;
		}
		callbackContext.error(0);
		return false;
	}

	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		callbackContext.success();

	}

}
