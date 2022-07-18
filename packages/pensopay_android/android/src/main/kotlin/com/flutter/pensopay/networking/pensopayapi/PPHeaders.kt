package com.flutter.pensopay.networking.pensopayapi

import android.util.Base64
import com.flutter.pensopay.PensoPay

internal class PPHeaders {

    private val apiKey
        get() = PensoPay.instance.apiKey

    fun setToken() : String {
        return String.format("Bearer %s", apiKey)
    }
}