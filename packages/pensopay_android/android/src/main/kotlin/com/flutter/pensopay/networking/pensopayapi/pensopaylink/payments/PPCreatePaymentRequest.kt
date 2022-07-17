package com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPAddress
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPBasket
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPayment
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPShipping
import org.json.JSONObject

class PPCreatePaymentRequest(params: PPCreatePaymentParameters): PPrequest<PPPayment>(Request.Method.POST, "/payments", params, PPPayment::class.java)

class PPCreatePaymentParameters(currency: String, order_id: String): JSONObject() {

    // Required Properties

    var currency: String = currency
    var order_id: String = order_id


    // Optional Properties

    var branding_id: Int? = null
    var text_on_statement: String? = null
    var basket: List<PPBasket>? = ArrayList()
    var shipping: PPShipping? = null
    var invoice_address: PPAddress? = null
    var shipping_address:PPAddress? = null

}