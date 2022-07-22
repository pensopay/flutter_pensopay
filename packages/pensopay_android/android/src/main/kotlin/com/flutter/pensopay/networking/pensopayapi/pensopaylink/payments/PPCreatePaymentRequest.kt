package com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments

import com.android.volley.Request
import com.flutter.pensopay.PensoPayActivity
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPAddress
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPBasket
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPayment
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPShipping
import org.json.JSONObject

class PPCreatePaymentRequest(params: PPCreatePaymentParameters): PPrequest<PPPayment>(Request.Method.POST, "/payment", params, PPPayment::class.java)

class PPCreatePaymentParameters(amount: Int, currency: String, order_id: String, facilitator: String, callback_url: String?, autocapture: Boolean, testmode: Boolean): JSONObject() {

    // Required Properties

    var amount: Int = amount
    var currency: String = currency
    var order_id: String = order_id
    var facilitator: String = facilitator
    var autocapture: Boolean = autocapture
    var testmode: Boolean = testmode
    var callback_url: String? = callback_url

    var success_url = PensoPayActivity.SUCCESS_URL
    var cancel_url = PensoPayActivity.FAILURE_URL


    // Optional Properties

    var branding_id: Int? = null
    var text_on_statement: String? = null
    var basket: List<PPBasket>? = ArrayList()
    var shipping: PPShipping? = null
    var invoice_address: PPAddress? = null
    var shipping_address:PPAddress? = null

}