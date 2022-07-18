package com.flutter.pensopay

enum class PaymentMethods(val id: String) {

//    MOBILEPAY("PaymentMobilePay"),
    PAYMENTCARD("PaymentCard");

    fun defaultTitle(): String {
        /*
        if (this == MOBILEPAY) {
            return "MobilePay"
        }
        */
        if (this == PAYMENTCARD) {
            return "Cards"
        }
        else {
            return ""
        }
    }

}