package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject

class PPMandate: JSONObject() {

    var id: Int = 0
    var subscription_id: String = ""
    var mandate_id: String = ""
    var state: String = ""
    var facilitator: String = ""
    var callback_url: String? = null
    var link: String = ""
    var reference: String = ""
    var created_at: String = ""
    var updated_at: String = ""

}