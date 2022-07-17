package com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPayment

class PPGetPaymentRequest(id: Int): PPrequest<PPPayment>(Request.Method.GET, "/payments/$id", null, PPPayment::class.java)