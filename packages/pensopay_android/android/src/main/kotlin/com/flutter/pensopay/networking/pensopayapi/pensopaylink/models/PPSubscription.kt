package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject

class PPSubscription: JSONObject() {

    var id: Int = 0
    var merchant_id: Int = 0
    var order_id: String = ""
    var accepted: Boolean = false
    var type: String = ""
    var currency: String = ""
    var state: String = ""
    var test_mode: Boolean = true
    var created_at: String = ""
    var updated_at: String = ""

    var text_on_statement: String? = null
    var branding_id: String? = null
    var acquirer: String? = null
    var facilitator: String? = null
    var retented_at: String? = null
    var description: String? = null
    var group_ids: Array<Int>? = null
    var deadline_at: String? = null

    var operations: Array<PPOperation>? = null
    var shipping_address: PPAddress? = null
    var invoice_address: PPAddress? = null
    var basket: Array<PPBasket>? = null
    var shipping: PPShipping? = null
    var metadata: PPMetadata? = null
    var link: PPPaymentLink? = null

}