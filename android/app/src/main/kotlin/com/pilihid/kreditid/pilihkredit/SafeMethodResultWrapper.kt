package com.pilihid.kreditid.padelgo

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.atomic.AtomicBoolean

class SafeMethodResultWrapper(private val result: MethodChannel.Result) : MethodChannel.Result {
    private val hasReplied = AtomicBoolean(false)
    private val handler = Handler(Looper.getMainLooper())

    override fun success(resultData: Any?) {
        if (hasReplied.compareAndSet(false, true)) {
            handler.post { result.success(resultData) }
        }
    }

    override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        if (hasReplied.compareAndSet(false, true)) {
            handler.post { result.error(errorCode, errorMessage, errorDetails) }
        }
    }

    override fun notImplemented() {
        if (hasReplied.compareAndSet(false, true)) {
            handler.post { result.notImplemented() }
        }
    }
}
