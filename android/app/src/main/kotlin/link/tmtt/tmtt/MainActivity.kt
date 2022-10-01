package link.tmtt.tmtt

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.PersistableBundle
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

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
                "getPlatformVersion" -> {
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                    return@setMethodCallHandler
                }

                "shareInstagramImageStoryWithSticker" -> {

                    val videoPath: String? = call.argument("videoPath")
                    val stickerPath: String? = call.argument("stickerPath")

                    if (videoPath != null && stickerPath != null) {
                        val videoUri = getUri(videoPath)
                        val stickerUri = getUri(stickerPath)
                        shareInstagramImageStoryWithSticker(videoUri, stickerUri)

                        result.success("Send video and sticker with success")
                        return@setMethodCallHandler
                    }
                }
                else-> result.notImplemented()
            }

        }
    }


    private fun getUri(filePath: String): Uri {
        val file = File(filePath)
        return FileProvider.getUriForFile(
            context,
            context.packageName.toString() + ".provider",
            file
        )
    }

    private fun shareInstagramImageStoryWithSticker(urlVideo: Uri, uriSticker: Uri) {

        val storiesIntent = Intent("com.instagram.share.ADD_TO_STORY").apply {
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            setPackage("com.instagram.android")
            setDataAndType(urlVideo, "video/*")
            putExtra("interactive_asset_uri", uriSticker)
            putExtra("content_url", "something");
            putExtra("top_background_color", "#33FF33")
            putExtra("bottom_background_color", "#FF00FF")
        }

        context.grantUriPermission(
            "com.instagram.android",
            uriSticker,
            Intent.FLAG_GRANT_READ_URI_PERMISSION
        )
        context.startActivity(storiesIntent)
    }


    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
    }
}
