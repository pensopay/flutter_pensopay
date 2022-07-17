package com.flutter.pensopay.networking.pensopayapi.pensopaylink.models

import org.json.JSONObject

class PPBasket(qty: Int,
               item_no: String,
               item_name: String,
               item_price: Double,
               vat_rate: Double): JSONObject() {

    // Required properties

    var qty: Int = qty
    var item_no: String = item_no
    var item_name: String = item_name
    var item_price: Double = item_price
    var vat_rate: Double = vat_rate

}
