package com.flutter.pensopay.networking;

import android.content.Context;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.Volley;

// Singleton class, to access an instance of Volley to send http requests.
public class NetworkUtility {

    private static NetworkUtility instance = null;
    private final RequestQueue requestQueue;

    // Private constructor for Singleton pattern.
    private NetworkUtility(Context context) {
        requestQueue = Volley.newRequestQueue(context.getApplicationContext());
    }

    public static synchronized void init(Context context) {
        instance = new NetworkUtility(context);
        instance.requestQueue.start();
    }

    /**
     * Use this method to retrieve an instance of NetworkUtility, which allows you to add http requests to the volley.RequestQueue.
     * You are required the call NetworkUtility.getInstance(context) first, otherwise an IllegalStateExpection is thrown.
     * @return An instance of NetworkUtility.
     */
    public static NetworkUtility getInstance() {
        if (instance == null) {
            throw new IllegalStateException("No NetworkUtility has been created. You need to call NetworkUtility.init( context ) first.");
        } else {
            return instance;
        }
    }

    public <T> void addNetworkRequest(Request<T> req){
        requestQueue.add(req);
    }

}