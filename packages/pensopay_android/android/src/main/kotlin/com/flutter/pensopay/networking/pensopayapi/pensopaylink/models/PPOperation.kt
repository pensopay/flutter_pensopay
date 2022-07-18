package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject

class PPOperation(id: Int): JSONObject() {

    // Required Properties

    var id: Int = id


    // Optional Properties

    var type: String? = null
    var amount: Int? = null
    var pending: Boolean? = null
    var pp_status_code: String? = null
    var pp_status_msg: String? = null
    var aq_status_msg: String? = null
    var aqStatusMsg: String? = null
    var data: Map<String, String>? = null
    var callback_url: String? = null
    var callback_success: Boolean? = null
    var callback_response_code: Int? = null
    var callback_duration: Int? = null
    var acquirer: String? = null
    var callback_at: String? = null
    var created_at: String? = null

}