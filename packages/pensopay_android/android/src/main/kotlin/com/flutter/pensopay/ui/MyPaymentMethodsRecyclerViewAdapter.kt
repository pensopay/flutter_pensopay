package com.flutter.pensopay.ui

import android.content.res.Resources
import android.graphics.Color
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView

import kotlinx.android.synthetic.main.fragment_paymentmethods.view.*
import com.flutter.pensopay.PaymentMethods
import com.flutter.pensopay.R

class MyPaymentMethodssRecyclerViewAdapter(
    private val mValues: List<PaymentContent.PaymentItem>,
    private val mListener: PaymentMethodssFragment.OnPaymentMethodssListFragmentInteractionListener?,
    private val recyclerView: androidx.recyclerview.widget.RecyclerView
) : androidx.recyclerview.widget.RecyclerView.Adapter<MyPaymentMethodssRecyclerViewAdapter.ViewHolder>() {

    private val mOnClickListener: View.OnClickListener

    init {
        mOnClickListener = View.OnClickListener { v ->
            // Reset the selection color of all the items
            for (index in 0..itemCount) {
                recyclerView.getChildAt(index)?.setBackgroundResource(R.drawable.border_background)
            }

            v.setBackgroundResource(R.drawable.border_background_selected)


            val item = v.tag as PaymentContent.PaymentItem
            // Notify the active callbacks interface (the activity, if the fragment is attached to
            // one) that an item has been selected.
            mListener?.onPaymentMethodsSelected(item.method)
        }


    }

    override fun getItemViewType(position: Int): Int {
        return if (mValues[position].method == PaymentMethods.PAYMENTCARD) {
            0
        } else {
            1
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return if (viewType == 0) {
            ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.fragment_paymentmethod_cards, parent, false))
        }
        else {
            ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.fragment_paymentmethods, parent, false))
        }
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = mValues[position]
        holder.mTitleView.text = item.toString()

        with(holder.mView) {
            tag = item
            setOnClickListener(mOnClickListener)
        }
    }

    override fun getItemCount(): Int = mValues.size

    inner class ViewHolder(val mView: View) : androidx.recyclerview.widget.RecyclerView.ViewHolder(mView) {
        val mTitleView: TextView = mView.item_title
        val mLayout: LinearLayout = mView.item_layout
    }
}
