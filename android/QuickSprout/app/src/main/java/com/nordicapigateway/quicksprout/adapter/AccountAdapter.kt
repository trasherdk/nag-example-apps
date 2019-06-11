package com.nordicapigateway.quicksprout.adapter

import android.content.Intent
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.LinearLayout
import com.nordicapigateway.quicksprout.R
import com.nordicapigateway.quicksprout.activity.TransactionsActivity
import kotlinx.android.synthetic.main.view_holder_account.view.*
import org.json.JSONArray
import org.json.JSONObject


class AccountAdapter(private val data: JSONArray, private val accessToken: String) : RecyclerView.Adapter<AccountAdapter.AccountViewHolder>() {

    class AccountViewHolder(
        val container: LinearLayout)
        : RecyclerView.ViewHolder(container)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): AccountViewHolder {
        val container = LayoutInflater.from(parent.context).inflate(R.layout.view_holder_account, parent, false) as LinearLayout
        return AccountViewHolder(container)
    }

    override fun onBindViewHolder(holder: AccountViewHolder, position: Int) {
        val account = data[position] as JSONObject
        holder.container.providerId.text = account.get("providerId").toString()
        holder.container.name.text = account.get("name").toString()
        holder.container.iban.text = (account.get("number") as JSONObject).getString("iban")
        holder.container.bookedCurrency.text = (account.get("bookedBalance") as JSONObject).getString("currency")
        holder.container.bookedAmount.text = (account.get("bookedBalance") as JSONObject).getString("value")
        holder.container.setOnClickListener {
            val intent = Intent(holder.container.context, TransactionsActivity::class.java).apply {
                putExtra("id", (this@AccountAdapter.data[position] as JSONObject).get("id").toString())
                putExtra("accessToken", accessToken)
            }
            holder.container.context.startActivity(intent)
        }
    }

    override fun getItemCount() = data.length()

}