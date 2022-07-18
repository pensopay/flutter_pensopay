package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject

class PPPayment: JSONObject() {

    // Properties

    var id: Int = 0
    var captured: Int = 0
    var refunded: Int = 0
    var order_id: String = ""
    var accepted: Boolean = false
    var type: String = ""
    var currency: String = ""
    var state: String = ""
    var testmode: Boolean = false
    var autocapture: Boolean = false
    var created_at: String = ""
    var updated_at: String = ""
    var expires_at: String = ""

    var callback_url: String? = null
    var link: String? = null
    var success_url: String? = null
    var facilitator: String? = null
    var cancel_url: String? = null

//    var operations: List<PPOperation>? = null
//    var shipping_address: PPAddress? = null
//    var invoice_address: PPAddress? = null
//    var basket: List<PPBasket>? = null
//    var shipping: PPShipping? = null
//    var metadata: PPMetadata? = null
//    var link: PPPaymentLink? = null
}