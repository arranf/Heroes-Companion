package com.heroescompanion.app;

import android.os.Bundle;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.view.FlutterView;


public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.heroescompanion.app/screen";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
      new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, Result result) {
          FlutterView view = getFlutterView();
          if (call.method.equals("setScreenNoSleep")){
            view.setKeepScreenOn(true);
          } else if (call.method.equals("setScreenCanSleep")) {
            view.setKeepScreenOn(false);
          }
        }
    });
  }
}
