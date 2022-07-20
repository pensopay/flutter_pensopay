package com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments

import com.android.volley.Request

import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPaymentLink
import org.json.JSONObject

import com.flutter.pensopay.PensoPayActivity

class PPCreatePaymentLinkRequest(params: PPCreatePaymentLinkParameters): PPrequest<PPPaymentLink>(Request.Method.GET, "/payment/${params.id}", params, PPPaymentLink::class.java) {

    init {
        params.cancel_url = PensoPayActivity.FAILURE_URL
        params.success_url = PensoPayActivity.SUCCESS_URL
    }

}

class PPCreatePaymentLinkParameters(var id: Int, var amount: Int): JSONObject() {
    // Optional Properties

    var agreement_id: Int? = null
    var language: String? = null
    var success_url: String? = null
    var cancel_url: String? = null
    var callback_url: String? = null
    var payment_methods: String? = null
    var auto_fee: Boolean? = null
    var branding_id: Int? = null
    var google_analytics_tracking_id: String? = null
    var google_analytics_client_id: String? = null
    var acquirer: String? = null
    var deadline: String? = null
    var framed: Int? = null
    //    var branding_config: Any?
    var customer_email: String? = null
    var invoice_address_selection: Boolean? = null
    var shipping_address_selection: Boolean? = null
    var autocapture: Int? = null

}