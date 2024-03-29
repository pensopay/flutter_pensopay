package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject
import kotlin.collections.HashMap

class PPSubscription: JSONObject() {

    var id: Int = 0
    var subscription_id: String = ""
    var amount: Int = 0
    var currency: String = ""
    var state: String = ""
    var description: String = ""
    var callback_url: String? = null
    var variables: Map<String, Any>? = null
    var created_at: String = ""
    var updated_at: String = ""

}