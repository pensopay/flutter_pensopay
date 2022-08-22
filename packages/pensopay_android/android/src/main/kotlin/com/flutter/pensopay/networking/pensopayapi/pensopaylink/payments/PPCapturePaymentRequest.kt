package com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.*
import org.json.JSONObject

class PPCapturePaymentRequest(params: PPCapturePaymentParameters): PPrequest<PPPayment>(Request.Method.POST, "/payments/${params.payment_id}/capture", params, PPPayment::class.java) {}


class PPCapturePaymentParameters(payment_id: Int, amount: Int?): JSONObject() {

    // Required Properties
    var payment_id: Int = payment_id

    // Optional Properties
    var amount: Int? = amount

}