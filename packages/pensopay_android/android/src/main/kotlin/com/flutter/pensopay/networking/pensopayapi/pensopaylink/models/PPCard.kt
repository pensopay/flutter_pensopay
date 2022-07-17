package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject

class PPCard: JSONObject() {

    // Optional Properties

    var number: String? = null
    var expiration: String? = null
    var cvd: String? = null
    var token: String? = null
    // var apple_pay_token: JSONObject() - Will never be used on Android
    var issued_to: String? = null
    var brand: String? = null // TODO: Convert this to an array of enums instead
    var status: String? = null
    var eci: String? = null
    var xav: String? = null
    var cavv: String? = null

}