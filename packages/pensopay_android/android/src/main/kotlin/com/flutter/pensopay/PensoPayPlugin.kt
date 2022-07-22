package com.flutter.pensopay

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.src.main.kotlin.com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions.PPUpdateSubscriptionParameters
import android.src.main.kotlin.com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions.PPUpdateSubscriptionRequest
import androidx.annotation.NonNull
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.mandate.PPCreateMandateParameters
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.mandate.PPCreateMandateRequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.mandate.PPGetMandateRequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPMandate
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.MethodChannel.Result
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPayment
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPaymentLink
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPSubscription
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.payments.*
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions.PPCreateSubscriptionParameters
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions.PPCreateSubscriptionRequest
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.subscriptions.PPGetSubscriptionRequest

/** PensoPayPlugin */
class PensoPayPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
    private lateinit var context: Context
    private lateinit var activity: Activity
    private lateinit var channel: MethodChannel
    private var pendingResult: Result? = null

    private var currentPaymentId: Int? = null
    private var currentType: String? = null

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

        // Payment calls
        private const val METHOD_CALL_CREATE_PAYMENT = "createPayment"
        private const val METHOD_CALL_GET_PAYMENT = "getPayment"
        private const val METHOD_CALL_CAPTURE_PAYMENT = "capturePayment"
        private const val METHOD_CALL_REFUND_PAYMENT = "refundPayment"
        private const val METHOD_CALL_CANCEL_PAYMENT = "cancelPayment"

        // Subscription calls
        private const val METHOD_CALL_CREATE_SUBSCRIPTION = "createSubscription"
        private const val METHOD_CALL_GET_SUBSCRIPTION = "getSubscription"
        private const val METHOD_CALL_UPDATE_SUBSCRIPTION = "updateSubscription"
        private const val METHOD_CALL_CANCEL_SUBSCRIPTION = "cancelSubscription"
        private const val METHOD_CALL_RECURRING_SUBSCRIPTION = "recurringSubscription"

        // Mandate calls
        private const val METHOD_CALL_CREATE_MANDATE = "createMandate"

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
                    if (currentPaymentId != null && currentType == "payment") {
                        val getPaymentRequest = PPGetPaymentRequest(currentPaymentId!!)

                        getPaymentRequest.sendRequest(
                                listener = { payment ->
                                    pendingResult?.success(convertPPPaymentToMap(payment))
                                    currentPaymentId = null
                                    currentType = null
                                },
                                errorListener = { _, message, error ->
                                    pendingResult?.error(PAYMENT_FAILURE_ERROR, message, error?.message)
                                }
                        )
                    } else if (currentPaymentId != null && currentType == "mandate") {
//                        val getSubscriptionRequest = PPGetSubscriptionRequest(currentPaymentId!!)
//
//                        getSubscriptionRequest.sendRequest(
//                            listener = { subscription ->
//                                pendingResult?.success(convertPPSubsriptionToMap(subscription))
//                                currentPaymentId = null
//                                currentType = null
//                            },
//                            errorListener = { _, message, error ->
//                                pendingResult?.error(PAYMENT_FAILURE_ERROR, message, error?.message)
//                            }
//                        )
//                    } else if (currentPaymentId != null && currentType == "mandate") {
                        val getMandateRequest = PPGetMandateRequest(currentPaymentId!!)

                        getMandateRequest.sendRequest(
                            listener = { mandate ->
                                pendingResult?.success(convertPPMandateToMap(mandate))
                                currentPaymentId = null
                                currentType = null
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
            // Payment methods
            METHOD_CALL_CREATE_PAYMENT -> {
                val currency = call.argument<String>("currency")!!
                val order_id = call.argument<String>("order_id")!!
                val amount = call.argument<Int>("amount")!!
                val facilitator = call.argument<String>("facilitator")!!
                val autocapture = call.argument<Boolean>("autocapture")
                val testmode = call.argument<Boolean>("testmode")
                createPayment(currency, order_id, amount, facilitator, autocapture, testmode)
            }
            METHOD_CALL_GET_PAYMENT -> {
                val payment_id = call.argument<Int>("payment_id")!!
                getPayment(payment_id)
            }
            METHOD_CALL_CAPTURE_PAYMENT -> {
                val payment_id = call.argument<Int>("payment_id")!!
                val amount = call.argument<Int>("amount")
                capturePayment(payment_id, amount)
            }
            METHOD_CALL_REFUND_PAYMENT -> {
                val payment_id = call.argument<Int>("payment_id")!!
                val amount = call.argument<Int>("amount")
                refundPayment(payment_id, amount)
            }
            METHOD_CALL_CANCEL_PAYMENT -> {
                val payment_id = call.argument<Int>("payment_id")!!
                cancelPayment(payment_id)
            }
            // Subscription methods
            METHOD_CALL_CREATE_SUBSCRIPTION -> {
                val subscription_id = call.argument<String>("subscription_id")!!
                val amount = call.argument<Int>("amount")!!
                val currency = call.argument<String>("currency")!!
                val description = call.argument<String>("description")!!
                val callback_url = call.argument<String>("callback_url")
                createSubscription(subscription_id, amount, currency, description, callback_url)
            }
            METHOD_CALL_GET_SUBSCRIPTION -> {
                val subscription_id = call.argument<Int>("subscription_id")!!
                getSubscription(subscription_id)
            }
            METHOD_CALL_UPDATE_SUBSCRIPTION -> {
                val id = call.argument<Int>("id")!!
                val subscription_id = call.argument<String>("subscription_id")
                val amount = call.argument<Int>("amount")
                val currency = call.argument<String>("currency")
                val description = call.argument<String>("description")
                val callback_url = call.argument<String>("callback_url")
                updateSubscription(id, subscription_id, amount, currency, description, callback_url)
            }
            METHOD_CALL_CANCEL_SUBSCRIPTION -> {
                val subscription_id = call.argument<Int>("subscription_id")!!
//                cancelSubscription(subscription_id)
            }
            METHOD_CALL_RECURRING_SUBSCRIPTION -> {
                val id = call.argument<Int>("id")!!
                val order_id = call.argument<String>("order_id")!!
                val currency = call.argument<String>("currency")!!
                val amount = call.argument<Int>("amount")!!
                val facilitator = call.argument<String>("facilitator")!!
                val autocapture = call.argument<Boolean>("autocapture")
                val testmode = call.argument<Boolean>("testmode")
//                recurringSubscription(id, currency, order_id, amount, facilitator, autocapture, testmode)
            }
            // Mandate methods
            METHOD_CALL_CREATE_MANDATE -> {
                val subscription_id = call.argument<Int>("subscription_id")!!
                val mandate_id = call.argument<String>("mandate_id")!!
                val facilitator = call.argument<String>("facilitator")!!
                createMandate(subscription_id, mandate_id, facilitator)
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

    private fun createPayment(currency: String, order_id: String, amount: Int, facilitator: String, autocapture: Boolean?, testmode: Boolean?) {
        val createPaymentParams = PPCreatePaymentParameters(amount, currency, order_id, facilitator, autocapture as Boolean, testmode as Boolean)
        val createPaymentRequest = PPCreatePaymentRequest(createPaymentParams)

        PensoPay.log(amount.toString())
        PensoPay.log(currency)
        PensoPay.log(order_id)
        PensoPay.log(facilitator)

        try {
            createPaymentRequest.sendRequest(
                    listener = { payment ->
                        currentPaymentId = payment.id
                        currentType = "payment"

                        val link = PPPaymentLink()
                        link.url = payment.link

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
            pendingResult?.error(PENSO_PAY_SETUP_ERROR, exception.message, exception.cause)
        }
    }

    private fun getPayment(payment_id: Int) {
        val getPaymentRequest = PPGetPaymentRequest(payment_id)

        try {
            getPaymentRequest.sendRequest(
                    listener = { payment ->
                        pendingResult?.success(convertPPPaymentToMap(payment))
                    },
                    errorListener = { _, message, error ->
                        PensoPay.log(message.toString())
                        PensoPay.log(error.toString())
                        pendingResult?.error(CREATE_PAYMENT_ERROR, message, error?.message)
                    }
            )
        } catch (exception: Exception) {
            PensoPay.log(exception.message.toString())
            pendingResult?.error(PENSO_PAY_SETUP_ERROR, exception.message, exception.cause)
        }
    }

    private fun capturePayment(payment_id: Int, amount: Int?) {
        val capturePaymentParams = PPCapturePaymentParameters(payment_id, amount)
        val capturePaymentRequest = PPCapturePaymentRequest(capturePaymentParams)

        try {
            capturePaymentRequest.sendRequest(
                    listener = { payment ->
                        pendingResult?.success(convertPPPaymentToMap(payment))
                    },
                    errorListener = { _, message, error ->
                        PensoPay.log(message.toString())
                        PensoPay.log(error.toString())
                        pendingResult?.error(CREATE_PAYMENT_ERROR, message, error?.message)
                    }
            )
        } catch (exception: Exception) {
            PensoPay.log(exception.message.toString())
            pendingResult?.error(PENSO_PAY_SETUP_ERROR, exception.message, exception.cause)
        }
    }

    private fun refundPayment(payment_id: Int, amount: Int?) {
        val refundPaymentParams = PPRefundPaymentParameters(payment_id, amount)
        val refundPaymentRequest = PPRefundPaymentRequest(refundPaymentParams)

        try {
            refundPaymentRequest.sendRequest(
                    listener = { payment ->
                        pendingResult?.success(convertPPPaymentToMap(payment))
                    },
                    errorListener = { _, message, error ->
                        PensoPay.log(message.toString())
                        PensoPay.log(error.toString())
                        pendingResult?.error(CREATE_PAYMENT_ERROR, message, error?.message)
                    }
            )
        } catch (exception: Exception) {
            PensoPay.log(exception.message.toString())
            pendingResult?.error(PENSO_PAY_SETUP_ERROR, exception.message, exception.cause)
        }
    }

    private fun cancelPayment(payment_id: Int) {
        val cancelPaymentRequest = PPCancelPaymentRequest(payment_id)

        try {
            cancelPaymentRequest.sendRequest(
                    listener = { payment ->
                        pendingResult?.success(convertPPPaymentToMap(payment))
                    },
                    errorListener = { _, message, error ->
                        PensoPay.log(message.toString())
                        PensoPay.log(error.toString())
                        pendingResult?.error(CREATE_PAYMENT_ERROR, message, error?.message)
                    }
            )
        } catch (exception: Exception) {
            PensoPay.log(exception.message.toString())
            pendingResult?.error(PENSO_PAY_SETUP_ERROR, exception.message, exception.cause)
        }
    }

    private fun createSubscription(subscription_id: String, amount: Int, currency: String, description: String, callback_url: String?) {
        val createSubscriptionParams = PPCreateSubscriptionParameters(subscription_id, amount, currency, description, callback_url)
        val createSubscriptionRequest = PPCreateSubscriptionRequest(createSubscriptionParams)

        try {
            createSubscriptionRequest.sendRequest(
                listener = { subscription ->
                    currentPaymentId = subscription.id
                    currentType = "subscription"

                    pendingResult?.success(convertPPSubsriptionToMap(subscription))
                },
                errorListener = { _, message, error ->
                    PensoPay.log(message.toString())
                    PensoPay.log(error.toString())
                    pendingResult?.error(CREATE_PAYMENT_ERROR, message, error?.message)
                }
            )
        } catch (exception: Exception) {
            PensoPay.log(exception.message.toString())
            pendingResult?.error(PENSO_PAY_SETUP_ERROR, exception.message, exception.cause)
        }
    }

    private fun getSubscription(subscription_id: Int) {
        val getSubscriptionRequest = PPGetSubscriptionRequest(subscription_id)

        try {
            getSubscriptionRequest.sendRequest(
                listener = { subscription ->
                    pendingResult?.success(convertPPSubsriptionToMap(subscription))
                },
                errorListener = { _, message, error ->
                    PensoPay.log(message.toString())
                    PensoPay.log(error.toString())
                    pendingResult?.error(CREATE_PAYMENT_ERROR, message, error?.message)
                }
            )
        } catch (exception: Exception) {
            PensoPay.log(exception.message.toString())
            pendingResult?.error(PENSO_PAY_SETUP_ERROR, exception.message, exception.cause)
        }
    }

    private fun updateSubscription(id: Int, subscription_id: String?, amount: Int?, currency: String?, description: String?, callback_url: String?) {
        val updateSubscriptionParams = PPUpdateSubscriptionParameters(id, subscription_id, amount, currency, description, callback_url)
        val updateSubscriptionRequest = PPUpdateSubscriptionRequest(updateSubscriptionParams)

        try {
            updateSubscriptionRequest.sendRequest(
                listener = { subscription ->
                    currentPaymentId = subscription.id
                    currentType = "subscription"

                    pendingResult?.success(convertPPSubsriptionToMap(subscription))
                },
                errorListener = { _, message, error ->
                    PensoPay.log(message.toString())
                    PensoPay.log(error.toString())
                    pendingResult?.error(CREATE_PAYMENT_ERROR, message, error?.message)
                }
            )
        } catch (exception: Exception) {
            PensoPay.log(exception.message.toString())
            pendingResult?.error(PENSO_PAY_SETUP_ERROR, exception.message, exception.cause)
        }
    }

    private fun createMandate(subscription_id: Int, mandate_id: String, facilitator: String) {
        val createMandateParams = PPCreateMandateParameters(subscription_id, mandate_id, facilitator)
        val createMandateRequest = PPCreateMandateRequest(createMandateParams)

        try {
            createMandateRequest.sendRequest(
                listener = { mandate ->
                    currentPaymentId = mandate.id
                    currentType = "mandate"

                    val link = PPPaymentLink()
                    link.url = mandate.link

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
            pendingResult?.error(PENSO_PAY_SETUP_ERROR, exception.message, exception.cause)
        }
    }

    private fun convertPPPaymentToMap(payment: PPPayment): Map<String, Any?> {
        return mapOf(
                "id" to payment.id,
                "order_id" to payment.order_id,
                "type" to payment.type,
                "amount" to payment.amount,
                "captured" to payment.captured,
                "refunded" to payment.refunded,
                "currency" to payment.currency,
                "state" to payment.state,
                "facilitator" to payment.facilitator,
                "reference" to payment.reference,
                "testmode" to payment.testmode,
                "autocapture" to payment.autocapture,
                "link" to payment.link,
                "callback_url" to payment.callback_url,
                "success_url" to payment.success_url,
                "cancel_url" to payment.cancel_url,
                "order" to payment.order,
                "variables" to payment.variables,
                "expires_at" to payment.expires_at,
                "created_at" to payment.created_at,
                "updated_at" to payment.updated_at
        )
    }

    private fun convertPPSubsriptionToMap(subscription: PPSubscription): Map<String, Any?> {
        return mapOf(
            "id" to subscription.id,
            "subscription_id" to subscription.subscription_id,
            "amount" to subscription.amount,
            "currency" to subscription.currency,
            "state" to subscription.state,
            "description" to subscription.description,
            "callback_url" to subscription.callback_url,
            "variables" to subscription.variables,
            "created_at" to subscription.created_at,
            "updated_at" to subscription.updated_at
        )
    }

    private fun convertPPMandateToMap(mandate: PPMandate): Map<String, Any?> {
        return mapOf(
            "id" to mandate.id,
            "subscription_id" to mandate.subscription_id,
            "mandate_id" to mandate.mandate_id,
            "state" to mandate.state,
            "facilitator" to mandate.facilitator,
            "callback_url" to mandate.callback_url,
            "link" to mandate.link,
            "reference" to mandate.reference,
            "created_at" to mandate.created_at,
            "updated_at" to mandate.updated_at
        )
    }

    override fun onReattachedToActivityForConfigChanges(activityPluginBinding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
}