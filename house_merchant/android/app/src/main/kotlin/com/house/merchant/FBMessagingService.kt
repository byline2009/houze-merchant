package com.house.merchant

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.media.RingtoneManager
import android.os.Build
import android.preference.PreferenceManager
import android.text.TextUtils
import android.util.Log
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.google.gson.Gson


class FBMessagingService : FirebaseMessagingService() {
    private var mChannel: NotificationChannel? = null
    private var notifManager: NotificationManager? = null
    override fun onNewToken(token: String) {
        super.onNewToken(token)
        Log.e("NEW TOKEN", token)
        val preferences = PreferenceManager.getDefaultSharedPreferences(baseContext)
        val edit = preferences.edit()
        edit.putString(MainActivity.TOKEN(), token)
        edit.apply()
    }

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)
        Log.d("FBMessagingService", "onMessageReceived  " + remoteMessage.data)
        val map = remoteMessage.data
        val title = map["title"]
        val message = map["message"]
        val data = map["data"]
        Log.d("FBMessagingService", data)
        if (!TextUtils.isEmpty(data)) {
            val gson = Gson()
            addNotification(title, message, data)
        }
    }

    private fun addNotification(title: String?, message: String?, data: String?) {
        val requestID = System.currentTimeMillis()
        if (notifManager == null) {
            notifManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val intent = Intent(this, MainActivity::class.java)
            val importance = NotificationManager.IMPORTANCE_HIGH
            if (mChannel == null) {
                mChannel = NotificationChannel(requestID.toString(), title, importance)
                //mChannel.enableVibration(true);
                notifManager!!.createNotificationChannel(mChannel)
            }
            intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
            intent.putExtra(MainActivity.DATA(), data)
            val pendingIntent = PendingIntent.getActivity(this, requestID.toInt(), intent, PendingIntent.FLAG_ONE_SHOT)
            val notification = Notification.Builder(baseContext, requestID.toString()).setContentTitle(title)
                    .setSmallIcon(notificationIcon)
                    .setDefaults(Notification.DEFAULT_ALL)
                    .setAutoCancel(true)
                    .setContentTitle(title)
                    .setContentText(message)
                    .setContentIntent(pendingIntent)
                    .setSound(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)).build()
            notifManager!!.notify(requestID.toInt(), notification)
        } else {
            val intent = Intent(this, MainActivity::class.java)
            intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
            intent.putExtra(MainActivity.DATA(), data)
            val pendingIntent = PendingIntent.getActivity(this, requestID.toInt(), intent, PendingIntent.FLAG_ONE_SHOT)
            val defaultSoundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
            val notificationBuilder = Notification.Builder(this)
                    .setContentTitle(title)
                    .setContentText(message)
                    .setAutoCancel(true)
                    .setSound(defaultSoundUri)
                    .setSmallIcon(notificationIcon)
                    .setContentIntent(pendingIntent)
            notifManager!!.notify(requestID.toInt(), notificationBuilder.build())
        }
    }

    /**
     * Get notification icon.
     */
    private val notificationIcon: Int
        private get() = R.mipmap.ic_launcher
}