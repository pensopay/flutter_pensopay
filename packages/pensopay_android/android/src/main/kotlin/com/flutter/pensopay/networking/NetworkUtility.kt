package com.flutter.pensopay.networking

import android.content.Context
import com.android.volley.Request
import com.android.volley.RequestQueue
import com.android.volley.toolbox.Volley

// Singleton class, to access an instance of Volley to send http requests.
class NetworkUtility private constructor(context: Context) {
    private val requestQueue: RequestQueue
    fun <T> addNetworkRequest(req: Request<T>?) {
        requestQueue.add(req)
    }

    companion object {
        private var instance: NetworkUtility? = null
        @Synchronized
        fun init(context: Context) {
            instance = NetworkUtility(context)
            instance!!.requestQueue.start()
        }

        /**
         * Use this method to retrieve an instance of NetworkUtility, which allows you to add http requests to the volley.RequestQueue.
         * You are required the call NetworkUtility.getInstance(context) first, otherwise an IllegalStateExpection is thrown.
         * @return An instance of NetworkUtility.
         */
        fun getInstance(): NetworkUtility? {
            return if (instance == null) {
                throw IllegalStateException("No NetworkUtility has been created. You need to call NetworkUtility.init( context ) first.")
            } else {
                instance
            }
        }
    }

    // Private constructor for Singleton pattern.
    init {
        requestQueue = Volley.newRequestQueue(context.getApplicationContext())
    }
}