package com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.*
import org.json.JSONObject
import java.util.*

class PPCreateSubscriptionRequest(params: PPCreateSubscriptionParameters): PPrequest<PPSubscription>(Request.Method.POST, "/subscription", params, PPSubscription::class.java)

class PPCreateSubscriptionParameters(subscription_id: String, amount: Int, currency: String, description: String, callback_url: String?): JSONObject() {

    // Required Properties

    var subscription_id: String = subscription_id
    var amount: Int = amount
    var currency: String = currency
    var description: String = description
    var callback_url: String? = callback_url


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