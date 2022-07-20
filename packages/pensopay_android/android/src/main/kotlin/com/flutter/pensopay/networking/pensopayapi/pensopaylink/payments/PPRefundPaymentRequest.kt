package com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.*
import org.json.JSONObject

class PPRefundPaymentRequest(params: PPRefundPaymentParameters): PPrequest<PPPayment>(Request.Method.POST, "/payment/${params.payment_id}/refund", params, PPPayment::class.java) {}


class PPRefundPaymentParameters(payment_id: Int, amount: Int?): JSONObject() {

    // Required Properties
    var payment_id: Int = payment_id

    // Optional Properties
    var amount: Int? = amount

}