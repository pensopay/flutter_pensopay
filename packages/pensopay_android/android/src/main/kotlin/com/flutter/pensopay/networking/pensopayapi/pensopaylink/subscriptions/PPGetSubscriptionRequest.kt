package com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPSubscription

class PPGetSubscriptionRequest(subscription_id: Int): PPrequest<PPSubscription>(Request.Method.GET, "/subscription/$subscription_id", null, PPSubscription::class.java)