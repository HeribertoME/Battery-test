package com.example.cpu.bad

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.cpu.bad.databinding.ActivityCpuBinding

class CpuActivity : AppCompatActivity() {

    private lateinit var binding: ActivityCpuBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityCpuBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.list.layoutManager = LinearLayoutManager(this)
        val adapter = MainAdapter()
        binding.list.adapter = adapter

        for (i in 0 until 100) {
            adapter.add(Data(title = "Holman Beasley",
                date = 1428269768649, imageRes = 0))
            adapter.add(Data(title = "Stone Kidd",
                date = 1451418572731, imageRes = 0))
            adapter.add(Data(title = "Santos Dunlap",
                date = 1433545054011, imageRes = 0))
            adapter.add(Data(title = "Mooney Miranda",
                date = 1510624404842, imageRes = 0))
            adapter.add(Data(title = "Marian Hanson",
                date = 1467900453706, imageRes = 0))
            adapter.add(Data(title = "Cotton Stevenson",
                date = 1412726746959, imageRes = 0))
            adapter.add(Data(title = "Felicia Norman",
                date = 1437812933902, imageRes = 0))
            adapter.add(Data(title = "Clemons Clemons",
                date = 1455441076372, imageRes = 0))
            adapter.add(Data(title = "Jaime Webster",
                date = 1526476773545, imageRes = 0))
            adapter.add(Data(title = "Salas Sparks",
                date = 1448727114005, imageRes = 0))
            adapter.add(Data(title = "Lorem Ipsum",
                date = 1448725614005, imageRes = 0))
            adapter.add(Data(title = "Dummy Text",
                date = 1446617113005, imageRes = 0))
        }
        adapter.notifyDataSetChanged()
    }
}