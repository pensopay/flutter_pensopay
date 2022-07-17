package com.flutter.pensopay

import android.os.Build
import android.webkit.WebResourceError
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebViewClient
import com.flutter.pensopay.PensoPayActivity.Companion.FAILURE_URL
import com.flutter.pensopay.PensoPayActivity.Companion.SUCCESS_URL


public class PensoPayWebViewClient(
    private val onDone: (data: String) -> Unit,
    private val onError: (error: WebResourceError?) -> Unit = {}
) : WebViewClient() {

    override fun shouldOverrideUrlLoading(view: WebView?, url: String): Boolean =
        when {
            url.contains(SUCCESS_URL) -> handleResult(PensoPayActivity.SUCCESS_RESULT)
            url.contains(FAILURE_URL) -> handleResult(PensoPayActivity.FAILURE_RESULT)
            else -> false
        }

    override fun onReceivedError(
        view: WebView?,
        request: WebResourceRequest?,
        error: WebResourceError?
    ) {
        onError(error)
        when {
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP -> PensoPay.Companion.log("onReceivedError: " + request?.url)
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.M -> PensoPay.Companion.log("onReceivedError: Error: " + error?.description)
        }
    }

    private fun handleResult(data: String): Boolean {
        onDone(data)
        return true
    }
}