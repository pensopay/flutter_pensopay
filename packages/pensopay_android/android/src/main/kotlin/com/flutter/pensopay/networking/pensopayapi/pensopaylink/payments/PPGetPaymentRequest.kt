package com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPayment

class PPGetPaymentRequest(payment_id: Int): PPrequest<PPPayment>(Request.Method.GET, "/payments/$payment_id", null, PPPayment::class.java)