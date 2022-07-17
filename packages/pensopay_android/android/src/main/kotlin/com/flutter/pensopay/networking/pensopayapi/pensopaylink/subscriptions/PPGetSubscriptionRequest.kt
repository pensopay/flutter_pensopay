package com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPSubscription

class PPGetSubscriptionRequest(id: Int): PPrequest<PPSubscription>(Request.Method.GET, "/subscriptions/$id", null, PPSubscription::class.java)