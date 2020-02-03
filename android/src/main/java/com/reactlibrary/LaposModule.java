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
import com.mpos.sdk.callbacks.OperationCompletion;

public class LaposModule extends ReactContextBaseJavaModule implements ActivityEventListener {

    String developerToken = "dt_7635070623c3685bfa18a8b85cb5817959334ff248d511c9832b788d94985fc4";
    String sessionToken = "st_cac12c02749d670616eede73a18aedfd44a3185ea1f4500c75206c9fdf83a3d2";

    private final ReactApplicationContext reactContext;

    private int PAYMENT_CODE = 1;
    private int REFUND_CODE = 2;

    public LaposModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        reactContext.addActivityEventListener(this); //Register this native module as Activity result listener
    }

    @Override
    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
      // Here is your Activity result :)

           WritableMap params = Arguments.createMap();
           params.putInt("onActivityResult", 1);

          if (data != null) {
              if (data.hasExtra(SdkConstants.KEY_ERROR_CODE) && data.hasExtra(SdkConstants.KEY_ERROR_MESSAGE)) {
                  int errorCode = data.getIntExtra(SdkConstants.KEY_ERROR_CODE, 0);
                  String errorMessage = data.getStringExtra(SdkConstants.KEY_ERROR_MESSAGE);

                  if (errorCode != 0) {
                      params.putString("error", errorMessage);
                      //sendEvent("EventReminder", params);
  //                     val message = "$errorCode $errorMessage"
  //                     resultDescription.text = message
                  }
              } else if (resultCode == -1 || resultCode == activity.RESULT_OK) {
                  params.putBoolean("result", true);
                  params.putInt("resultCode", resultCode);

                  if (requestCode == REFUND_CODE || requestCode == PAYMENT_CODE) {
                        params.putString("resultResponse", data.getStringExtra(SdkConstants.KEY_SDK_RESPONSE));
                  }
                  //sendEvent("EventReminder", params);
  //                 when (requestCode) {
  //                     REFUND_CODE, PAYMENT_CODE -> resultDescription.text = data.getStringExtra(SdkConstants.KEY_SDK_RESPONSE)
  //                 }
              }
              else{
                  params.putBoolean("error", true);
                  //sendEvent("EventReminder", params);

                  //resultDescription.text = "failed"
              }
          }
          else{
              params.putBoolean("OtherError", true);
              //sendEvent("EventReminder", params);
              //resultDescription.text = "failed"
          }
          sendEvent("EventReminder", params);

    }

    @Override
    public void onNewIntent(Intent intent) {

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
    public void initSdk(String stringArgument, Callback callback) {
        // TODO: Implement some actually useful functionality
        LaPosMovilSDK.Companion.init(developerToken, this.reactContext);
        LaPosMovilSDK.Companion.getInstance().setSdkSessionToken(sessionToken);

        callback.invoke(null, true);

//         WritableMap params = Arguments.createMap();
//         params.putBoolean("initSdk", true);
//         sendEvent("EventReminder", params);
    }

    @ReactMethod
    public void payEvent(double amount, String description/*, Callback callback*/) {

        final Activity activity = reactContext.getCurrentActivity();

        // TODO: Implement some actually useful functionality
        // activity, requestCode, amount, description, externalreference
        LaPosMovilSDK.Companion.getInstance().makePayment(activity, PAYMENT_CODE, amount, description, null);

    }

    @ReactMethod
    public void sendEmail(int id, String email) {

        LaPosMovilSDK.Companion.getInstance().sendReceiptForOperationId(
            id,
            email,
            new OperationCompletion() {
               public void onOperationSuccess(String result) {
                   WritableMap params = Arguments.createMap();
                   params.putBoolean("sendEmail", true);
                   params.putString("resultEmail", result);
                   sendEvent("EventReminder", params);
               }
               public void onOperationFailed(int errorCode, String errorMessage) {
                   WritableMap params = Arguments.createMap();
                   params.putBoolean("sendEmail", false);
                   params.putString("errorEmail", errorMessage);
                   sendEvent("EventReminder", params);
               }
            }
        );
    }
}

