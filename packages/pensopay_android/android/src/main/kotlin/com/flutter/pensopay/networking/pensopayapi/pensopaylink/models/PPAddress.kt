package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject

class PPAddress: JSONObject() {

    // Optional Properties

    var name: String? = null
    var att: String? = null
    var street: String? = null
    var city: String? = null
    var zip_code: String? = null
    var region: String? = null
    var country_code: String? = null
    var vat_no: String? = null
    var company_name: String? = null
    var house_number: String? = null
    var house_extension: String? = null
    var phone_number: String? = null
    var mobile_number: String? = null
    var email: String? = null

}