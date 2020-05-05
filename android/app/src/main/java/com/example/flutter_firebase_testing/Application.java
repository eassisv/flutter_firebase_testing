package com.example.flutter_firebase_testing;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
// import com.example.flutter_firebase_test.FCMPluginRegistrant;
// import com.example.flutter_firebase_test.LocalNotificationsPluginRegistrant;

public class Application extends FlutterApplication implements PluginRegistrantCallback {
  @Override
  public void onCreate() {
    super.onCreate();
    FlutterFirebaseMessagingService.setPluginRegistrant(this);
  }

  @Override
  public void registerWith(PluginRegistry registry) {
    FCMPluginRegistrant.registerWith(registry);
    LocalNotificationsPluginRegistrant.registerWith(registry);
  }
}
