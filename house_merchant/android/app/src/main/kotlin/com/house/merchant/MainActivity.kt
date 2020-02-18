package com.house.merchant

import android.content.Intent
import android.os.Bundle
import android.preference.PreferenceManager.getDefaultSharedPreferences
import androidx.annotation.NonNull

import io.flutter.app.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
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

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      if (call.method == TOKEN()) {

        val token = getDefaultSharedPreferences(baseContext).getString(TOKEN(), "")
        result.success(token)

      } else {
        result.notImplemented()
      }
    }

    EventChannel(flutterView, RECEIVE_NOTIFICATION).setStreamHandler(object : EventChannel.StreamHandler {
      override fun onListen(o: Any?, eventSink: EventChannel.EventSink?) {
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
