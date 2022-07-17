package com.flutter.pensopay.networking

import android.util.Log
import com.android.volley.AuthFailureError
import com.android.volley.NetworkResponse
import com.android.volley.ParseError
import com.android.volley.Response
import com.android.volley.toolbox.HttpHeaderParser
import com.android.volley.toolbox.JsonRequest
import com.google.gson.Gson
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

class ObjectRequest<T>(
    method: Int, url: String, params: JSONObject?, clazz: java.lang.Class<*>,
    listener: Response.Listener<T>, errorListener: Response.ErrorListener?
) :
    JsonRequest<T>(method, url, Gson().toJson(params), listener, errorListener) {
    private val clazz: java.lang.Class<*>
    private val listener: Response.Listener<T>
    val url: String
    private var mRequestBody: String? = null
    private var mHeaders: Map<String, String>? = null
    val body: ByteArray?
        get() = try {
            if (mRequestBody == null) null else mRequestBody.toByteArray(
                charset(
                    PROTOCOL_CHARSET
                )
            )
        } catch (e: UnsupportedEncodingException) {
            Log.e(
                TAG, "Unsupported Encoding while trying to get the bytes of " + mRequestBody +
                        "using " + PROTOCOL_CHARSET
            )
            null
        }

    protected fun deliverResponse(response: T) {
        listener.onResponse(response)
    }

    protected fun parseNetworkResponse(response: NetworkResponse): Response {
        return try {
            val json = String(response.data, HttpHeaderParser.parseCharset(response.headers))
            if (clazz.getName() == JSONObject::class.java.getName()) {
                try {
                    val `object` = JSONObject(json)
                    Response.success(`object`, HttpHeaderParser.parseCacheHeaders(response))
                } catch (ex: JSONException) {
                    Response.error(ParseError(ex))
                }
            } else if ((clazz.getName() == JSONArray::class.java.getName())) {
                try {
                    val `object` = JSONArray(json)
                    Response.success(`object`, HttpHeaderParser.parseCacheHeaders(response))
                } catch (ex: JSONException) {
                    Response.error(ParseError(ex))
                }
            } else {
                Response.success(
                    Gson().fromJson(json, clazz),
                    HttpHeaderParser.parseCacheHeaders(response)
                )
            }
        } catch (e: UnsupportedEncodingException) {
            Log.e(TAG, Objects.requireNonNull(e.message))
            Response.error(ParseError(e))
        }
    }

    @get:Throws(AuthFailureError::class)
    var headers: Map<String, String>?
        get() {
            return if (mHeaders!!.isEmpty()) {
                super.getHeaders()
            } else {
                mHeaders
            }
        }
        set(headers) {
            mHeaders = headers
        }

    companion object {
        private const val PROTOCOL_CHARSET = "utf-8"
        private const val TAG = "ObjectRequest"
    }

    init {
        this.clazz = clazz
        this.listener = listener
        if (params != null) {
            mRequestBody = Gson().toJson(params)
        }
        this.url = url
    }
}