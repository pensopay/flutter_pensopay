package com.flutter.pensopay.networking.pensopayapi

import android.util.Base64
import com.flutter.pensopay.PensoPay

internal class PPHeaders {

    // Properties

    val acceptVersion
        get() = "v10"

    private val apiKey
        get() = PensoPay.instance.apiKey


    // Auth

    fun encodedAuthorization() : String {
        val credentials = String.format("%s:%s", "", apiKey)
        return "Basic " + Base64.encodeToString(
               credentials.toByteArray(),
               Base64.NO_WRAP
        ) // NO_WRAP is required, otherwise line breaks can occur, which are not allowed in http headers.
    }
}