package com.example.assemblyhello

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView

/**
 * Main Activity that loads the native ARM64 library and displays
 * the string returned from the assembly code.
 */
class MainActivity : AppCompatActivity() {

    // Static block to load the native library on startup
    companion object {
        init {
            System.loadLibrary("assemblyhello")
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Get the TextView reference and set text from native code
        val tv: TextView = findViewById(R.id.sample_text)
        tv.text = stringFromJNI()
    }

    /**
     * Native method declaration.
     * This method is implemented in pure ARM64 assembly language
     * in the native-lib.S file.
     *
     * @return String - The message "Hello from assembly!" created by native code
     */
    external fun stringFromJNI(): String
}
