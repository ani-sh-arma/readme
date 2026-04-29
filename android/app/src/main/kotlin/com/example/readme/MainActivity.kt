package com.example.readme

import android.os.Build
import android.view.KeyEvent
import com.github.junrar.Archive
import com.github.junrar.rarfile.FileHeader
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {

    private val cbr_channel = "com.example.readme/cbr"
    private val mobi_channel = "com.example.readme/mobi"
    private val volume_channel = "com.example.readme/volume_keys"

    private var volumeEventSink: EventChannel.EventSink? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // --- CBR extraction channel ---
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            cbr_channel,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "extractCbr" -> {
                    val path = call.argument<String>("path")
                    val destDir = call.argument<String>("destDir")
                    if (path == null || destDir == null) {
                        result.error("INVALID_ARGS", "path and destDir are required", null)
                        return@setMethodCallHandler
                    }
                    Thread {
                        try {
                            val files = extractCbr(path, destDir)
                            result.success(files)
                        } catch (e: Exception) {
                            result.error("EXTRACT_FAILED", e.message, null)
                        }
                    }.start()
                }
                else -> result.notImplemented()
            }
        }

        // --- MOBI/AZW conversion channel ---
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            mobi_channel,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "convertToHtml" -> {
                    val path = call.argument<String>("path")
                    val destFile = call.argument<String>("destFile")
                    if (path == null || destFile == null) {
                        result.error("INVALID_ARGS", "path and destFile are required", null)
                        return@setMethodCallHandler
                    }
                    Thread {
                        try {
                            val htmlPath = convertMobiToHtml(path, destFile)
                            result.success(htmlPath)
                        } catch (e: Exception) {
                            result.error("CONVERT_FAILED", e.message, null)
                        }
                    }.start()
                }
                else -> result.notImplemented()
            }
        }

        // --- Volume key event channel ---
        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            volume_channel,
        ).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    volumeEventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    volumeEventSink = null
                }
            },
        )
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        return when (keyCode) {
            KeyEvent.KEYCODE_VOLUME_DOWN -> {
                volumeEventSink?.success("down")
                true
            }
            KeyEvent.KEYCODE_VOLUME_UP -> {
                volumeEventSink?.success("up")
                true
            }
            else -> super.onKeyDown(keyCode, event)
        }
    }

    /** Extracts a CBR/RAR archive to [destDir] and returns sorted image paths. */
    private fun extractCbr(path: String, destDir: String): List<String> {
        val dest = File(destDir).also { it.mkdirs() }
        val archive = Archive(File(path))
        val paths = mutableListOf<String>()
        archive.use { arc ->
            val headers: List<FileHeader> = arc.fileHeaders
            for (header in headers) {
                if (header.isDirectory) continue
                val name = header.fileName.replace('\\', '/')
                val ext = name.substringAfterLast('.', "").lowercase()
                if (ext !in listOf("jpg", "jpeg", "png", "webp", "gif")) continue
                val outFile = File(dest, File(name).name)
                FileOutputStream(outFile).use { out -> arc.extractFile(header, out) }
                paths.add(outFile.absolutePath)
            }
        }
        return paths.sorted()
    }

    /**
     * Converts a MOBI/AZW file to HTML using Apache Tika and writes the result
     * to [destFile]. Returns the path to the written HTML file.
     *
     * Tika is a large dependency; if size is a concern consider replacing with
     * a lightweight custom Palm-format reader.
     */
    private fun convertMobiToHtml(path: String, destFile: String): String {
        val inputFile = File(path)
        val outputFile = File(destFile).also { it.parentFile?.mkdirs() }

        val tika = org.apache.tika.Tika()
        val html = tika.parseToString(inputFile)

        outputFile.writeText(html)
        return outputFile.absolutePath
    }
}

