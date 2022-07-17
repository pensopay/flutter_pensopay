package com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.*
import org.json.JSONObject
import java.util.*

class PPCreateSubscriptionRequest(params: PPCreateSubscriptionParameters): PPrequest<PPSubscription>(Request.Method.POST, "/subscriptions", params, PPSubscription::class.java)

class PPCreateSubscriptionParameters(currency: String, order_id: String, description: String): JSONObject() {

    // Required Properties

    var order_id: String = order_id
    var currency: String = currency
    var description: String = description


    // Optional Properties

    var branding_id: Int? = null
    var text_on_statement: String? = null
    var basket: MutableList<PPBasket>? = LinkedList<PPBasket>()
    var shipping: PPShipping? = null
    var invoice_address: PPAddress? = null
    var shipping_address:PPAddress? = null
    var group_ids: Array<Int>? = null
    var shopsystem: Array<PPShopSystem>? = null

}