package com.flutter.pensopay.networking.pensopayapi.pensopaylink.mandate

import com.android.volley.Request
import com.flutter.pensopay.PensoPayActivity
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPMandate
import org.json.JSONObject
import java.util.*

class PPCreateMandateRequest(params: PPCreateMandateParameters): PPrequest<PPMandate>(Request.Method.POST, "/subscription/${params.subscription_id}/mandate", params, PPMandate::class.java)

class PPCreateMandateParameters(subscription_id: Int, mandate_id: String, facilitator: String): JSONObject() {

    // Required Properties

    var subscription_id: Int = subscription_id
    var mandate_id: String = mandate_id
    var facilitator: String = facilitator

    var success_url: String = PensoPayActivity.SUCCESS_URL
    var cancel_url: String = PensoPayActivity.FAILURE_URL

}