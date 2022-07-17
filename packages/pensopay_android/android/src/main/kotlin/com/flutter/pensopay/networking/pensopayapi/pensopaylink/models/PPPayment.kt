package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject

class PPPayment: JSONObject() {

    // Properties

    var id: Int = 0
    var merchant_id: Int = 0
    var order_id: String = ""
    var accepted: Boolean = false
    var type: String = ""
    var text_on_statement: String? = null
    var currency: String = ""
    var state: String = ""
    var test_mode: Boolean = false
    var created_at: String = ""
    var updated_at: String = ""
    var balance: Int = 0

    var branding_id: String? = null
    var acquirer: String? = null
    var facilitator: String? = null
    var retented_at: String? = null
    var fee: Int? = null
    var subscriptionId: Int? = null
    var deadline_at: String? = null

    var operations: List<PPOperation>? = null
    var shipping_address: PPAddress? = null
    var invoice_address: PPAddress? = null
    var basket: List<PPBasket>? = null
    var shipping: PPShipping? = null
    var metadata: PPMetadata? = null
    var link: PPPaymentLink? = null
}