package com.nordicapigateway.quicksprout.activity

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.view.MenuItem
import android.widget.Button
import com.nordicapigateway.quicksprout.R
import com.nordicapigateway.quicksprout.adapter.TransactionsAdapter
import com.nordicapigateway.quicksprout.api.IQuickSproutAPI
import com.nordicapigateway.quicksprout.api.QuickSproutAPI
import org.json.JSONArray
import org.json.JSONObject

class TransactionsActivity : AppCompatActivity() {

    private lateinit var recyclerView: RecyclerView
    private lateinit var viewAdapter: TransactionsAdapter
    private lateinit var viewManager: RecyclerView.LayoutManager
    private lateinit var transactionPaging: Button
    private lateinit var transactions: JSONArray
    private lateinit var pagingToken: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_transactions)
        transactionPaging = this@TransactionsActivity.findViewById(R.id.transactionPaging)
        supportActionBar?.title = "Transactions"
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        val id = intent.getStringExtra("id")
        intent.getStringExtra("accessToken")?.let {
            QuickSproutAPI(this@TransactionsActivity).transactions(it, id, object : IQuickSproutAPI {
                override fun onTransactions(TransactionsObject: JSONObject) {
                    transactions = TransactionsObject.getJSONArray("transactions")
                    pagingToken = TransactionsObject.getString("pagingToken")
                    viewManager = LinearLayoutManager(this@TransactionsActivity)
                    viewAdapter = TransactionsAdapter(transactions)
                    recyclerView = this@TransactionsActivity.findViewById<RecyclerView>(R.id.recyclerView).apply {
                        setHasFixedSize(true)
                        layoutManager = viewManager
                        adapter = viewAdapter
                    }
                }
            })
        }

        transactionPaging.setOnClickListener {
            val accessToken = intent.getStringExtra("accessToken")
            if (pagingToken.isNotEmpty()){
                let {
                    QuickSproutAPI(this@TransactionsActivity).transactions(accessToken, id, object : IQuickSproutAPI {
                        override fun onTransactions(TransactionsObject: JSONObject) {
                            val newTransactions = TransactionsObject.getJSONArray("transactions")
                            transactions = mergeArrays(transactions, newTransactions)
                            pagingToken = TransactionsObject.getString("pagingToken")

                            viewAdapter.setData(transactions)
                            viewAdapter.notifyDataSetChanged()
                        }
                    }, pagingToken = pagingToken)
                }
            }
        }
    }

    override fun onOptionsItemSelected(item: MenuItem?): Boolean {
        if(item?.itemId == android.R.id.home) {
            finish()
        }
        return super.onOptionsItemSelected(item)
    }

    fun mergeArrays(left: JSONArray, right: JSONArray): JSONArray {
        var result = JSONArray()

        for (i in 0 until left.length())
            result.put(left.get(i))
        for (i in 0 until right.length())
            result.put(right.get(i))

        return result
    }
}

