package android.src.main.kotlin.com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions

import com.android.volley.Request
import com.flutter.pensopay.networking.pensopayapi.PPrequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.*
import org.json.JSONObject
import java.util.*

class PPUpdateSubscriptionRequest(params: PPUpdateSubscriptionParameters): PPrequest<PPSubscription>(Request.Method.PATCH, "/subscription/${params.id}", params, PPSubscription::class.java)

class PPUpdateSubscriptionParameters(id: Int, subscription_id: String?, amount: Int?, currency: String?, description: String?, callback_url: String?): JSONObject() {

    // Required Properties
    var id: Int = id

    // Optional Properties
    var subscription_id: String? = subscription_id
    var amount: Int? = amount
    var currency: String? = currency
    var description: String? = description
    var callback_url: String? = callback_url

}