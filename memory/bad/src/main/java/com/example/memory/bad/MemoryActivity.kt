package com.example.memory.bad

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.memory.bad.databinding.ActivityMemoryBinding

class MemoryActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMemoryBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMemoryBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.list.layoutManager = LinearLayoutManager(this)
        val adapter = MainAdapter()
        binding.list.adapter = adapter

        for (i in 0 until 100) {
            adapter.add(
                Data(title = "Holman Beasley",
                date = 1428269768649, imageRes = R.drawable.sample_01)
            )
            adapter.add(
                Data(title = "Stone Kidd",
                date = 1451418572731, imageRes = R.drawable.sample_02)
            )
            adapter.add(
                Data(title = "Santos Dunlap",
                date = 1433545054011, imageRes = R.drawable.sample_03)
            )
            adapter.add(
                Data(title = "Mooney Miranda",
                date = 1510624404842, imageRes = R.drawable.sample_01)
            )
            adapter.add(
                Data(title = "Marian Hanson",
                date = 1467900453706, imageRes = R.drawable.sample_02)
            )
            adapter.add(
                Data(title = "Cotton Stevenson",
                date = 1412726746959, imageRes = R.drawable.sample_03)
            )
            adapter.add(
                Data(title = "Felicia Norman",
                date = 1437812933902, imageRes = R.drawable.sample_01)
            )
            adapter.add(
                Data(title = "Clemons Clemons",
                date = 1455441076372, imageRes = R.drawable.sample_02)
            )
            adapter.add(
                Data(title = "Jaime Webster",
                date = 1526476773545, imageRes = R.drawable.sample_03)
            )
            adapter.add(
                Data(title = "Salas Sparks",
                date = 1448727114005, imageRes = R.drawable.sample_01)
            )
            adapter.add(
                Data(title = "Lorem Ipsum",
                date = 1448725614005, imageRes = R.drawable.sample_02)
            )
            adapter.add(
                Data(title = "Dummy Text",
                date = 1446617113005, imageRes = R.drawable.sample_03)
            )
        }
        adapter.notifyDataSetChanged()
    }
}