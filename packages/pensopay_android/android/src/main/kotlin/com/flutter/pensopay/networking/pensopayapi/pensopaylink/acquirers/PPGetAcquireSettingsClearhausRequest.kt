package com.flutter.pensopay.networking.pensopayapi.pensopaylink.acquirers

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import org.json.JSONObject

internal class PPGetAcquireSettingsClearhausRequest(): PPrequest<PPClearhausSettings>(Request.Method.GET, "/acquirers/clearhaus", null, PPClearhausSettings::class.java) {}

internal class PPClearhausSettings : JSONObject() {

    var active: Boolean = false
    var api_key: String = ""
    var apple_pay: Boolean = false
    var recurring: Boolean = false
    var payout: Boolean = false
    var mpi_merchant_id: String? = null

}