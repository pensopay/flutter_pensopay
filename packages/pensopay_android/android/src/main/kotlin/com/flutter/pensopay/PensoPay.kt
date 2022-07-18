package com.flutter.pensopay

import android.content.Context
import android.util.Log
import com.flutter.pensopay.networking.NetworkUtility
import java.lang.RuntimeException

class PensoPay(internal var apiKey: String) {

    // Singleton

    companion object {
        private const val LOGTAG = "PensopayAct"

        private var backingInstance: PensoPay? = null
        var instance: PensoPay
            get() {
                return backingInstance ?: throw RuntimeException("The PensoPay SDK needs to be initialized before usage. \nPensoPay.init(\"<API_KEY>\", <CONTEXT>)")
            }
            private set(value) {
                backingInstance = value
            }

        // Static Init
        fun init(apiKey: String, context: Context) {
            NetworkUtility.init(context)
            instance = PensoPay(apiKey)

        }

        fun log(msg: String) {
            Log.d(LOGTAG, msg)
        }
    }
}