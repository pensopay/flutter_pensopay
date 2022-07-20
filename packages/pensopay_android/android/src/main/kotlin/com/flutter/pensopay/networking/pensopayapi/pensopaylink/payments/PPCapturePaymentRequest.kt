package com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.*
import org.json.JSONObject

class PPCapturePaymentRequest(params: PPCapturePaymentParameters): PPrequest<PPPayment>(Request.Method.POST, "/payment/${params.payment_id}/capture", params, PPPayment::class.java) {}


class PPCapturePaymentParameters(payment_id: Int, amount: Double?): JSONObject() {

    // Required Properties
    var payment_id: Int = payment_id

    // Optional Properties
    var amount: Double? = amount

}