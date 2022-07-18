package com.flutter.pensopay

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.flutter.pensopay.PensoPay
import com.flutter.pensopay.PensoPayActivity
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPayment
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPaymentLink
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments.*

/** PensoPayPlugin */
class PensoPayPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
    private lateinit var context: Context
    private lateinit var activity: Activity
    private lateinit var channel: MethodChannel
    private var pendingResult: Result? = null

    private var currentPaymentId: Int? = null

    override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
        activity = activityPluginBinding.activity
        activityPluginBinding.addActivityResultListener(this)
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "pensopay")
        channel.setMethodCallHandler(this)
    }

    companion object {
        private const val METHOD_CALL_INIT = "init"
        private const val METHOD_CALL_MAKE_PAYMENT = "makePayment"

        private const val PENSO_PAY_SETUP_ERROR = "0"
        private const val CREATE_PAYMENT_ERROR = "1"
        private const val CREATE_PAYMENT_LINK_ERROR = "2"
        private const val ACTIVITY_ERROR = "3"
        private const val ACTIVITY_FAILURE_ERROR = "4"
        private const val PAYMENT_FAILURE_ERROR = "5"

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "pensopay")
            channel.setMethodCallHandler(PensoPayPlugin())
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?): Boolean {
        if (requestCode == PensoPayActivity.PENSOPAY_INTENT_CODE) {
            if (resultCode == Activity.RESULT_OK) {
                val returnedResult = intent?.data?.toString() ?: ""

                if (returnedResult == PensoPayActivity.SUCCESS_RESULT) {
                    if (currentPaymentId != null) {
                        val getPaymentRequest = PPGetPaymentRequest(currentPaymentId!!)

                        getPaymentRequest.sendRequest(
                                listener = { payment ->
                                    pendingResult?.success(convertQPPaymentToMap(payment))
                                    currentPaymentId = null
                                },
                                errorListener = { _, message, error ->
                                    pendingResult?.error(PAYMENT_FAILURE_ERROR, message, error?.message)
                                }
                        )
                    }
                } else if (returnedResult == PensoPayActivity.FAILURE_RESULT) {
                    pendingResult?.error(ACTIVITY_FAILURE_ERROR, "PensoPayActivity failure", "")

                }
            } else if (requestCode == Activity.RESULT_CANCELED) {
                pendingResult?.error(ACTIVITY_ERROR, "Activity error", "")
            }

            return true
        }

        return false
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        pendingResult = result
        when (call.method) {
            METHOD_CALL_INIT -> {
                val apiKey = call.argument<String>("api-key") ?: return
                init(apiKey)
            }
            METHOD_CALL_MAKE_PAYMENT -> {
                val currency = call.argument<String>("currency")!!
                val orderId = call.argument<String>("order_id")!!
                val amount = call.argument<Double>("amount")!!
                val facilitator = call.argument<String>("facilitator")!!
                val autoCapture = call.argument<Boolean>("autocapture")
                makePayment(currency, orderId, amount, facilitator, autoCapture)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun init(apiKey: String) {
        PensoPay.init(apiKey, context)
    }

    private fun makePayment(currency: String, orderId: String, amount: Double, facilitator: String, autocapture: Boolean?) {
        val createPaymentParams = PPCreatePaymentParameters(amount, currency, orderId, facilitator, autocapture as Boolean)
        val createPaymentRequest = PPCreatePaymentRequest(createPaymentParams)

        PensoPay.log(amount.toString())
        PensoPay.log(currency)
        PensoPay.log(orderId)
        PensoPay.log(facilitator)

        try {
            createPaymentRequest.sendRequest(
                    listener = { payment ->
                        currentPaymentId = payment.id

                        val link = PPPaymentLink()
                        link.url = payment.link!!

                        PensoPayActivity.openPensoPayPaymentWindow(activity, link)
                    },
                    errorListener = { _, message, error ->
                        PensoPay.log(message.toString())
                        PensoPay.log(error.toString())
                        pendingResult?.error(CREATE_PAYMENT_ERROR, message, error?.message)
                    }
            )
        } catch (exception: Exception) {
            PensoPay.log(exception.message.toString())
            pendingResult?.error(PENSO_PAY_SETUP_ERROR, exception?.message, exception?.cause)
        }
    }

    private fun convertQPPaymentToMap(payment: PPPayment): Map<String, Any?> {
        return mapOf(
                "id" to payment.id,
                "order_id" to payment.order_id,
                "amount" to payment.accepted,
                "captured" to payment.captured,
                "refunded" to payment.refunded,
                "currency" to payment.currency,
                "state" to payment.state,
                "type" to payment.type,
                "facilitator" to payment.facilitator,
                "testmode" to payment.testmode,
                "autocapture" to payment.autocapture,
                "link" to payment.link,
                "callback_url" to payment.callback_url,
                "success_url" to payment.success_url,
                "cancel_url" to payment.cancel_url,
                "created_at" to payment.created_at,
                "updated_at" to payment.updated_at,
                "expires_at" to payment.expires_at,
//            "variables" to mapOf(
//                "type" to payment.metadata?.type,
//                "origin" to payment.metadata?.origin,
//                "brand" to payment.metadata?.brand,
//                "bin" to payment.metadata?.bin,
//                "corporate" to payment.metadata?.corporate,
//                "last4" to payment.metadata?.last4,
//                "exp_month" to payment.metadata?.exp_month,
//                "exp_year" to payment.metadata?.exp_year,
//                "country" to payment.metadata?.country,
//                "is_3d_secure" to payment.metadata?.is_3d_secure,
//                "issued_to" to payment.metadata?.issued_to,
//                "hash" to payment.metadata?.hash,
//                "number" to payment.metadata?.number,
//                "customer_ip" to payment.metadata?.customer_ip,
//                "customer_country" to payment.metadata?.customer_country,
//                "shopsystem_name" to payment.metadata?.shopsystem_name,
//                "shopsystem_version" to payment.metadata?.shopsystem_version
//            ),
//            "order" to mapOf(
//                "type" to payment.metadata?.type,
//                "origin" to payment.metadata?.origin,
//                "brand" to payment.metadata?.brand,
//                "bin" to payment.metadata?.bin,
//                "corporate" to payment.metadata?.corporate,
//                "last4" to payment.metadata?.last4,
//                "exp_month" to payment.metadata?.exp_month,
//                "exp_year" to payment.metadata?.exp_year,
//                "country" to payment.metadata?.country,
//                "is_3d_secure" to payment.metadata?.is_3d_secure,
//                "issued_to" to payment.metadata?.issued_to,
//                "hash" to payment.metadata?.hash,
//                "number" to payment.metadata?.number,
//                "customer_ip" to payment.metadata?.customer_ip,
//                "customer_country" to payment.metadata?.customer_country,
//                "shopsystem_name" to payment.metadata?.shopsystem_name,
//                "shopsystem_version" to payment.metadata?.shopsystem_version
//            ),
        )
    }

    override fun onReattachedToActivityForConfigChanges(activityPluginBinding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
}