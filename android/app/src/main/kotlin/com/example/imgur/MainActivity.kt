package com.example.imgur

import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
class MainActivity: FlutterActivity() {
      private var response: Map<String, String?>? = null

    override protected fun onResume() {
        super.onResume()
        var intent = getIntent()
        var action = intent.getAction()
        if (Intent.ACTION_VIEW.equals(action)) {
            handleSendText(intent)
        }
    }

    override public fun onNewIntent (intent:Intent) {
        setIntent(intent);
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler({ call, result ->
                    if (call.method.contentEquals("getImgurResponse")) {
                        result.success(response)
                        response = null
                    }
                })
    }

    internal fun handleSendText(intent: Intent) {
        var access_token: String? = null
        var refresh_token: String? = null
        var id: String? = null
        var username: String? = null
        var expires_in: String? = null

        intent.data.toString().split("#")[1].split("&").forEach {
            when (it.split("=")[0]) {
              
                "access_token" -> access_token = it.removePrefix("access_token=")
                "refresh_token" -> refresh_token = it.removePrefix("refresh_token=")
                "account_username" -> username = it.removePrefix("account_username=")
                "account_id" -> id = it.removePrefix("account_id=")
                "expires_in" -> expires_in = it.removePrefix("expires_in=")
            } 
        }
        
        var user = mapOf(
            "id" to id,
            "username" to username,
            "access_token" to access_token,
            "refresh_token" to refresh_token,
            "expires_in" to expires_in,
        )

        response = user
    }

    companion object {
        private val CHANNEL = "app.channel.shared.data"
    }
}
