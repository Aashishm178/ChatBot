package com.example.chatbot;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;

public class Application extends FlutterApplication implements PluginRegistry.PluginRegistrantCallback {
    @java.lang.Override
    public void registerWith(PluginRegistry registry) {
        FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
    }

    @java.lang.Override
    public void onCreate() {
        super.onCreate();
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }
}

