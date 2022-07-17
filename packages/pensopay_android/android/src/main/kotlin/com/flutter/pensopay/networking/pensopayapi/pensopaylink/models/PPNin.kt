package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject

class PPNin: JSONObject() {

    // Optional Properties

    var number: String? = null
    var country_code: String? = null
    var gender: String? = null //TODO: Convert this into the Gender enum

}