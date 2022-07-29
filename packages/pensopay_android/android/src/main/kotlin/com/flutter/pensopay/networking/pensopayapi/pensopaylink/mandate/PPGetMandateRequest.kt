package com.flutter.pensopay.networking.pensopayapi.pensopaylink.mandate

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPMandate
import com.flutter.pensopay.networking.pensopayapi.PPrequest

class PPGetMandateRequest(subscription_id: Int, mandate_id: String): PPrequest<PPMandate>(Request.Method.GET, "/subscription/$subscription_id/mandate/$mandate_id", null, PPMandate::class.java)