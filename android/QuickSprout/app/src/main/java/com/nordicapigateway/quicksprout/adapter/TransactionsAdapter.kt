package com.nordicapigateway.quicksprout.adapter

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.LinearLayout
import com.nordicapigateway.quicksprout.R
import kotlinx.android.synthetic.main.view_holder_transaction.view.*
import org.json.JSONArray
import org.json.JSONObject


class TransactionsAdapter(private var data: JSONArray) : RecyclerView.Adapter<TransactionsAdapter.TransactionsViewHolder>() {

    class TransactionsViewHolder(
        val container: LinearLayout)
        : RecyclerView.ViewHolder(container)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TransactionsViewHolder {
        val container = LayoutInflater.from(parent.context).inflate(R.layout.view_holder_transaction, parent, false) as LinearLayout
        return TransactionsViewHolder(container)
    }

    override fun onBindViewHolder(holder: TransactionsViewHolder, position: Int) {
        val transaction = data[position] as JSONObject
        holder.container.type.text = transaction.get("type").toString()
        holder.container.text.text = transaction.get("text").toString()
        holder.container.date.text = transaction.get("date").toString()
        val amount = transaction.get("amount") as JSONObject
        holder.container.amountView.text =  amount.get("value").toString() + " " + amount.get("currency").toString()
        val balance = transaction.get("balance") as JSONObject
        holder.container.balanceView.text =  balance.get("value").toString() + " " + balance.get("currency").toString()
        holder.container.state.text = transaction.get("state").toString()
    }

    override fun getItemCount() = data.length()

    fun setData(data: JSONArray) {
        this.data = data
    }
}