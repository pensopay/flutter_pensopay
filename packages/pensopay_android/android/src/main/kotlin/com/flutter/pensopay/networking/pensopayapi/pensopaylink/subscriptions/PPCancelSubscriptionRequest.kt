package com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPSubscription

class PPCancelSubscriptionRequest(id: Int): PPrequest<PPSubscription>(Request.Method.POST, "/subscription/$id/cancel", null, PPSubscription::class.java)