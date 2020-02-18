package com.house.merchant

import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

  val CHANNEL = "com.house.merchant"
  val RECEIVE_NOTIFICATION = CHANNEL + "/receive_notification"

  companion object {
    fun DATA() : String = "data"
    fun TOKEN() : String = "device_token"
  }

  private var openEventSink: EventChannel.EventSink? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
      if (call.method == TOKEN()) {

        val token = getDefaultSharedPreferences(baseContext).getString(TOKEN(), "")
        result.success(token)

      } else {
        result.notImplemented()
      }
    }

    EventChannel(flutterEngine.dartExecutor, RECEIVE_NOTIFICATION).setStreamHandler(object : EventChannel.StreamHandler {
      override fun onListen(o: Any?, eventSink: EventSink?) {
        openEventSink = eventSink
      }

      override fun onCancel(o: Any?) {}
    })
  }

  override fun onNewIntent(intent: Intent) {
    super.onNewIntent(intent)
    openEventSink!!.success(intent.getStringExtra(DATA()))
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    data?.let{
      super.onActivityResult(requestCode, resultCode, data)
    }
  }
}
