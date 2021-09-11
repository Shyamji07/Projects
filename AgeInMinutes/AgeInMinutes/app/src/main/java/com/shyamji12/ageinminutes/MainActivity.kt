package com.shyamji12.ageinminutes

import android.app.DatePickerDialog
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_main.*
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        button2.setOnClickListener {view ->
            clickDatePicker(view)
            }
    }
    fun clickDatePicker(view: View){

        val myCalander = Calendar.getInstance()
        val year=myCalander.get(Calendar.YEAR)
        val month =myCalander.get(Calendar.MONTH)
        val day = myCalander.get(Calendar.DAY_OF_MONTH)

        DatePickerDialog(this,DatePickerDialog.OnDateSetListener { view, selectedyear, selectedmonth, selecteddayOfMonth ->
         //   Toast.makeText(this,"YES $selectedmonth "+day,Toast.LENGTH_LONG).show()

            val selecteddate="$selecteddayOfMonth/${selectedmonth+1}/$selectedyear"

            tvSelectedDate.setText(selecteddate)

            val sdf=SimpleDateFormat("dd/MM/yyyy",Locale.ENGLISH)
            val theDate:Date =sdf.parse(selecteddate)
            val today =Date()

            val days:Long=(today.time-theDate.time)/86400000
            val hours:Long=(today.time-theDate.time)%86400000/3600000
            val minute:Long=(today.time-theDate.time)%86400000%3600000/60000
            val  result="${(days*24*60)+(hours*60)+minute}"

            tvSelectedDateInMinutes.setText(result)

        },year,month,day).show()
    }
}