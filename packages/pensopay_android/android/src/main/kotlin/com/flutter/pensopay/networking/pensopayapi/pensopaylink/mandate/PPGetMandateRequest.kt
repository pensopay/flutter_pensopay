package com.flutter.pensopay.networking.pensopayapi.pensopaylink.mandate

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPMandate
import com.flutter.pensopay.networking.pensopayapi.PPrequest

class PPGetMandateRequest(subscription_id: Int): PPrequest<PPMandate>(Request.Method.GET, "/payment/$subscription_id", null, PPMandate::class.java)