package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import android.src.main.kotlin.com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPOrder
import org.json.JSONObject

class PPPayment: JSONObject() {

    // Properties
    val id: Int = 0
    val order_id: String = ""
    val type: String = ""
    val amount = 0
    val captured = 0
    val refunded = 0
    val currency: String = ""
    val state: String = ""
    val facilitator: String = ""
    val reference: String = ""
    val testmode: Boolean = false
    val autocapture: Boolean = false
    val link: String = ""
    val callback_url: String = ""
    val success_url: String = ""
    val cancel_url: String = ""
    val order: List<PPOrder>? = null
    val variables: List<Any>? = null
    val expires_at: String = ""
    val created_at: String = ""
    val updated_at: String = ""
}