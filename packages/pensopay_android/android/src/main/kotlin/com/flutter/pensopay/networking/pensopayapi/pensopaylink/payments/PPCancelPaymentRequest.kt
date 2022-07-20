package com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPayment

class PPCancelPaymentRequest(payment_id: Int): PPrequest<PPPayment>(Request.Method.POST, "/payment/$payment_id/cancel", null, PPPayment::class.java)