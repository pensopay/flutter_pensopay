package com.flutter.pensopay.networking.pensopayapi

import com.android.volley.Response
import com.flutter.pensopay.PensoPay
import com.google.gson.Gson
import com.flutter.pensopay.networking.NetworkUtility
import com.flutter.pensopay.networking.ObjectRequest
import org.json.JSONObject
import java.lang.StringBuilder
import kotlin.collections.HashMap

/**
 * The PPRequest is a utility class that bridges the gap between PensoPay domain code and the general purpose networking code
 */
open class PPrequest<T>(private val method: Int, private val path: String, private val params: JSONObject?, private val clazz: Class<T>) {

    // Static

    companion object {
        protected const val apiBaseUrl = "https://stress-api.pensopay.dev/v1"
    }


    // Util

    private fun createHeaders() : Map<String, String> {
        val ppHeaders = PPHeaders()

        val headers = HashMap<String, String>()
        headers["Authorization"] = ppHeaders.setToken()
//        headers["Accept-Version"] = ppHeaders.acceptVersion
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"

        return headers
    }

    fun sendRequest(listener: (T) -> Unit, errorListener: ((statusCode: Int?, message: String?, ppError: PPError?) -> Unit)?) {
        val request = ObjectRequest<T>(method, "$apiBaseUrl$path", params, clazz, Response.Listener {
            listener.invoke(it)
        }, Response.ErrorListener {
            val message: String? = try {
                String(it.networkResponse.data)
            } catch (e: Exception) {
                it.message
            }

            val ppError: PPError? = try {
                Gson().fromJson(message, PPError::class.java)
            }
            catch (e: Exception) {
                null
            }

            errorListener?.invoke(it.networkResponse?.statusCode, it.message, ppError)
        })

        request.headers = createHeaders()

        // Debug info
        PensoPay.log("Adding request to queue")
        PensoPay.log("Method: ${request.method}")
        PensoPay.log("Url: ${request.url}")
        PensoPay.log("Headers: ${request.headers}")
        PensoPay.log("Params: ${params?.length()}")

        NetworkUtility.getInstance().addNetworkRequest(request)
    }
}

class PPError : JSONObject() {

    var message: String = ""
    var errors: Map<String, Array<String>>? = null
    var error_code: String? = null

    override fun toString(): String {
        val sb = StringBuilder("Message: $message")
        sb.append("\n")

        sb.append("Error_Code: $error_code")
        sb.append("\n")

        if(errors != null && errors?.isNotEmpty() == true) {
            errors?.keys?.forEach { key: String? ->
                sb.append("$key - ${errors?.get(key)?.firstOrNull()}")
                sb.append("\n")
            }
        }

        return sb.toString()
    }
}