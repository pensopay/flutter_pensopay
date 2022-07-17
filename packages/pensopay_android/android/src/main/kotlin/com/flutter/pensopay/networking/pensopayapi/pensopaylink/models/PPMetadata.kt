package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject

class PPMetadata: JSONObject() {

    // Optional Properties

    var type: String? = null
    var origin: String? = null
    var brand: String? = null
    var bin: String? = null
    var corporate: Boolean? = null
    var last4: String? = null
    var exp_month: Int? = null
    var exp_year: Int? = null
    var country: String? = null
    var is_3d_secure: Boolean? = null
    var issued_to: String? = null
    var hash: String? = null
    var number: String? = null
    var customer_ip: String? = null
    var customer_country: String? = null
    var fraud_suspected: Boolean? = null
    var fraud_remarks: List<String>? = null
    var fraud_reported: Boolean? = null
    var fraud_report_description: String? = null
    var fraud_reported_at: String? = null
    var nin_number: String? = null
    var nin_country_code: String? = null
    var nin_gender: String? = null
    var shopsystem_name: String? = null
    var shopsystem_version: String? = null

}