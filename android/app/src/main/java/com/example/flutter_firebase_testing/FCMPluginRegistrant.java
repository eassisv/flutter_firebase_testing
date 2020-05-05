package com.example.flutter_firebase_testing;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin;

public final class FCMPluginRegistrant {
    public static void registerWith(PluginRegistry registry) {
        if (alreadyRegisteredWith(registry)) {
            System.out.println(">>>>>>>>>>>>>FCM Returning<<<<<<<<<<<");
            return;
        }
        System.err.println(">>>>>>>>>FCM Registring<<<<<<<<");
        FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
        // FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
    }

    private static boolean alreadyRegisteredWith(PluginRegistry registry) {
        final String key = FCMPluginRegistrant.class.getCanonicalName();
        System.out.println(">>>>>>>>>>>>>> FCMPLUGIN <<<<<>>>>>" + key + "<<<<<<<<<<<<<<<<<");
        if (registry.hasPlugin(key)) {
            return true;
        }
        registry.registrarFor(key);
        return false;
    }
}
