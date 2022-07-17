package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject

class PPShipping: JSONObject() {

    // Optional Properties

    var method: String? = null
    var company: String? = null
    var amount: Int? = null
    var vat_rate: Double? = null
    var tracking_number: String? = null
    var tracking_url: String? = null

}