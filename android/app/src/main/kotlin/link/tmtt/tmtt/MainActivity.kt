package link.tmtt.tmtt

import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val INSTA_CHANNEL= "link.tmtt/shareinsta"
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel= MethodChannel(flutterEngine.dartExecutor.binaryMessenger, INSTA_CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when(call.method) {
                "sharePhotoToInstagram"-> {
                    //call.arguments as String
                    result.success("something to return")
                }
            }

        }
    }

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
    }
}
