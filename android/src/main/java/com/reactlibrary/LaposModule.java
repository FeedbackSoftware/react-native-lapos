package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.mpos.sdk.LaPosMovilSDK;

import android.content.Intent;
//import androidx.appcompat.app.AppCompatActivity;
import android.app.Activity;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;
import androidx.annotation.Nullable;
import com.facebook.react.bridge.BaseActivityEventListener;
import com.facebook.react.bridge.ActivityEventListener;
import com.mpos.sdk.constants.SdkConstants;

public class LaposModule extends ReactContextBaseJavaModule {

    String developerToken = "dt_7635070623c3685bfa18a8b85cb5817959334ff248d511c9832b788d94985fc4";
    String sessionToken = "st_cac12c02749d670616eede73a18aedfd44a3185ea1f4500c75206c9fdf83a3d2";

    private final ReactApplicationContext reactContext;

    private int PAYMENT_CODE = 1;
    private int REFUND_CODE = 2;

//     private final ActivityEventListener mActivityEventListener = new BaseActivityEventListener() {

//         @Override
//         public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
//
//             WritableMap params = Arguments.createMap();
//             params.putBoolean("onActivityResult", true);
//             sendEvent("EventReminder", params);

//               if (data != null) {
//                   if (data.hasExtra(SdkConstants.KEY_ERROR_CODE) && data.hasExtra(SdkConstants.KEY_ERROR_MESSAGE)) {
//                       val errorCode = data.getIntExtra(SdkConstants.KEY_ERROR_CODE, 0);
//                       val errorMessage = data.getStringExtra(SdkConstants.KEY_ERROR_MESSAGE);
//                       if (errorCode != 0) {
//                           val message = "$errorCode $errorMessage";
//                           resultDescription.text = message;
//                       }
//                   } else if (resultCode == RESULT_OK) {
//                       when (requestCode) {
//                           REFUND_CODE, PAYMENT_CODE -> resultDescription.text = data.getStringExtra(SdkConstants.KEY_SDK_RESPONSE);
//                       }
//                   }
//                   else{
//                       resultDescription.text = "failed";
//                   }
//               }
//               else{
//                   resultDescription.text = "failed";
//               }
              //super.onActivityResult(requestCode, resultCode, data)
//         }
//     };

    //@Override
     public void onActivityResult(int requestCode, int resultCode, Intent data) {

         WritableMap params = Arguments.createMap();

        if (data != null) {
            if (data.hasExtra(SdkConstants.KEY_ERROR_CODE) && data.hasExtra(SdkConstants.KEY_ERROR_MESSAGE)) {
                int errorCode = data.getIntExtra(SdkConstants.KEY_ERROR_CODE, 0);
                String errorMessage = data.getStringExtra(SdkConstants.KEY_ERROR_MESSAGE);

                params.putInt("resultCode", resultCode);

                if (errorCode != 0) {
                    params.putBoolean("result", false);
                    params.putString("data", errorMessage);
                    sendEvent("EventReminder", params);
//                     val message = "$errorCode $errorMessage"
//                     resultDescription.text = message
                }
            } else if (resultCode == 9999) {
                params.putBoolean("result", true);
                params.putString("data", SdkConstants.KEY_SDK_RESPONSE);
                sendEvent("EventReminder", params);
//                 when (requestCode) {
//                     REFUND_CODE, PAYMENT_CODE -> resultDescription.text = data.getStringExtra(SdkConstants.KEY_SDK_RESPONSE)
//                 }
            }
            else{
                params.putBoolean("result", false);
                sendEvent("EventReminder", params);

                //resultDescription.text = "failed"
            }
        }
        else{
            params.putBoolean("result", false);
            sendEvent("EventReminder", params);
            //resultDescription.text = "failed"
        }
        //super.onActivityResult(requestCode, resultCode, data);
     }

    public LaposModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    private void sendEvent(String eventName,
                           @Nullable WritableMap params) {
      reactContext
          .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
          .emit(eventName, params);
    }

    @Override
    public String getName() {
        return "Lapos";
    }

    @ReactMethod
    public void initSdk(String stringArgument/*, Callback callback*/) {
        // TODO: Implement some actually useful functionality
        LaPosMovilSDK.Companion.init(developerToken, this.reactContext);
        LaPosMovilSDK.Companion.getInstance().setSdkSessionToken(sessionToken);

        //callback.invoke("init" + stringArgument);

        WritableMap params = Arguments.createMap();
        params.putBoolean("initSdk", true);
        sendEvent("EventReminder", params);
    }

    @ReactMethod
    public void payEvent(double amount, String description/*, Callback callback*/) {

        final Activity activity = reactContext.getCurrentActivity();

        // TODO: Implement some actually useful functionality
        LaPosMovilSDK.Companion.getInstance().makePayment(activity, 1, amount, description, null);

        WritableMap params = Arguments.createMap();
        params.putBoolean("Process", true);
        sendEvent("EventReminder", params);

        //callback.invoke("Received amount: " + amount + " description: " + description);

    }
}
