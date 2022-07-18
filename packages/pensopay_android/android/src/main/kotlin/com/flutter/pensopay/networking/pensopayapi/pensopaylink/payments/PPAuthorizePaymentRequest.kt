package com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.*
import org.json.JSONObject

class PPAuthorizePaymentRequest(params: PPAuthorizePaymentParams): PPrequest<PPPayment>(Request.Method.POST, "/payment/${params.id}/authorize", params, PPPayment::class.java) {}


class PPAuthorizePaymentParams(id: Int, amount: Int): JSONObject() {

    // Required Properties

    var id: Int = id
    var amount: Int = amount


    // Optional Properties

    var pensopayCallbackUrl: String? = null // TODO: Must be encoded/decoded into 'PensoPay-Callback-Url'
    var synchronized: Boolean? = null
    var vat_rate: Double? = null
    var mobile_number: String? = null
    var auto_capture: Boolean? = null
    var acquirer: String? = null
    var autofee: Boolean? = null
    var customer_ip: String? = null
    //    var extras: Any?
    var zero_auth: Boolean? = null

    var card: PPCard? = null
    var nin: PPNin? = null
    var person: PPPerson? = null

}