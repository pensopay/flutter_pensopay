package com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPayment
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPerson
import org.json.JSONObject

class PPCreatePaymentSessionRequest(id: Int, params: PPCreatePaymentSessionParameters): PPrequest<PPPayment>(Request.Method.POST, "/payments/$id/session?synchronized", params, PPPayment::class.java)

class PPCreatePaymentSessionParameters(amount: Int): JSONObject() {

    constructor(amount: Int, mobilePayParameters: MobilePayParameters): this(amount) {
        extras["mobilepay"] = mobilePayParameters
        acquirer = "mobilepay"
    }


    // Required Properties

    var amount: Int = amount


    // Optional Properties

    var autocapture: Boolean? = null
    var acquirer: String? = null
    var autofee: Boolean? = null
    var customer_ip: String? = null
    var person: PPPerson? = null
    var extras: MutableMap<String, Any> = HashMap<String, Any>()

}

class MobilePayParameters(return_url: String): JSONObject() {

    constructor(return_url: String, language: String?, shop_logo_url: String?) : this(return_url) {
        this.language = language
        this.shop_logo_url = shop_logo_url
    }


    // Required Properties

    var return_url: String = return_url


    // Optional Properties

    var language: String? = null
    var shop_logo_url: String? = null

}