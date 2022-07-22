package com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions

import com.android.volley.Request
import com.flutter.pensopay.PensoPayActivity
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.*
import org.json.JSONObject
import java.util.*

class PPRecurringSubscriptionRequest(params: PPRecurringSubscriptionParameters): PPrequest<PPPayment>(Request.Method.POST, "/subscription/${params.id}/payment", params, PPPayment::class.java)

class PPRecurringSubscriptionParameters(id: Int, amount: Int, currency: String, order_id: String, callback_url: String?, testmode: Boolean?): JSONObject() {

    // Required Properties

    var id: Int = id
    var amount: Int = amount
    var currency: String = currency
    var order_id: String = order_id
    var testmode: Boolean? = testmode
    var callback_url: String? = callback_url

    var success_url = PensoPayActivity.SUCCESS_URL
    var cancel_url = PensoPayActivity.FAILURE_URL


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