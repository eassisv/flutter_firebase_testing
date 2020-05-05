package com.example.flutter_firebase_testing

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.firebaseauth.FirebaseAuthPlugin
import io.flutter.plugins.firebase.core.FirebaseCorePlugin
import io.flutter.plugins.googlesignin.GoogleSignInPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        flutterEngine.plugins.add(FirebaseAuthPlugin())
        flutterEngine.plugins.add(FirebaseCorePlugin())
        flutterEngine.plugins.add(GoogleSignInPlugin())
    }
}
