package com.flutter.pensopay

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.webkit.*
import androidx.appcompat.app.AppCompatActivity
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPPaymentLink
import com.flutter.pensopay.networking.pensopayapi.pensopaylink.models.PPSubscriptionLink

class PensoPayActivity : AppCompatActivity() {
    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val requestedUrl = intent.getStringExtra(urlPropertyName)
        setContentView(R.layout.activity_quick_pay)

        val webView = findViewById<WebView>(R.id.pensopay_webview)
        if (webView != null) {
            webView.settings.javaScriptEnabled = true
            webView.webChromeClient = WebChromeClient()

            webView.webViewClient = PensoPayWebViewClient(onDone = {
                val data = Intent()
                data.data = Uri.parse(it)

                // Close down the activity and deliver a result.
                this.setResult(Activity.RESULT_OK, data)
                this.finish()
            });

            webView.loadUrl(requestedUrl)
        }
    }

    companion object {
        const val SUCCESS_URL = "https://pensopay.payment.success"
        const val FAILURE_URL = "https://pensopay.payment.failure"
        const val SUCCESS_RESULT = "Success"
        const val FAILURE_RESULT = "Failure"
        private const val urlPropertyName = "pensopaylink"
        const val QUICKPAY_INTENT_CODE = 1318

        /**
         * Opens a view that allows you to enter payment information.
         *
         * @param a    The activity from which to send an intent.
         * @param link The PensoPay payment link, which was created by using a PPCreatePaymentLinkRequest.
         */
        fun openPensoPayPaymentWindow(a: Activity, link: PPPaymentLink) {
            openPensoPayPaymentWindow(a, link.url)
        }

        /**
         * Opens a view that allows you to enter payment information.
         *
         * @param a    The activity from which to send an intent.
         * @param link The PensoPay subscription link, which was created by using a PPCreateSubscriptionLinkRequest.
         */
        fun openPensoPayPaymentWindow(a: Activity, link: PPSubscriptionLink) {
            openPensoPayPaymentWindow(a, link.url)
        }

        private fun openPensoPayPaymentWindow(a: Activity, URL: String) {
            val intent = Intent(a, PensoPayActivity::class.java)
            intent.putExtra(urlPropertyName, URL)
            a.startActivityForResult(intent, QUICKPAY_INTENT_CODE)
        }
    }
}