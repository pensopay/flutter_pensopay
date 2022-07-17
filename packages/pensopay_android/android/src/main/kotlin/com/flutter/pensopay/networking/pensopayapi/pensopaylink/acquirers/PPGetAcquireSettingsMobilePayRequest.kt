package com.flutter.pensopay.networking.pensopayapi.pensopaylink.acquirers

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import org.json.JSONObject

internal class PPGetAcquireSettingsMobilePayRequest: PPrequest<PPMobilePaySettings>(Request.Method.GET, "/acquirers/mobilepay", null, PPMobilePaySettings::class.java)

internal class PPMobilePaySettings : JSONObject() {

    var active: Boolean = false
    var delivery_limited_to: String? = null

}