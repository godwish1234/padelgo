package com.pilihid.kreditid.padelgo

import android.annotation.SuppressLint
import android.app.Activity
import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.location.LocationManager
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.Uri
import android.net.wifi.WifiConfiguration
import android.net.wifi.WifiManager
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.os.Handler
import android.os.Looper
import android.os.StatFs
import android.os.SystemClock
import android.os.storage.StorageManager
import android.provider.ContactsContract
import android.provider.MediaStore
import android.provider.Settings
import android.telephony.TelephonyManager
import android.util.DisplayMetrics
import android.util.Log
import android.view.WindowManager
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.core.os.ConfigurationCompat
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.lang.reflect.Method
import java.math.BigDecimal
import java.math.RoundingMode
import java.net.NetworkInterface
import java.security.MessageDigest
import java.util.*
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import kotlin.math.PI
import kotlin.math.abs
import kotlin.math.atan2
import kotlin.math.round
import kotlin.math.sqrt


class MainActivity : FlutterActivity() {
    private val CHANNEL = "app_info_channel"
    private val CARMERA_CHANNEL = "carmera_channel"
    private val CONTACT_CHANNEL = "contact_channel"
    private var resultCallback: MethodChannel.Result? = null
    private val CONTACT_PICK_REQUEST = 1001

    private lateinit var sensorManager: SensorManager
    private var accelerometer: Sensor? = null
    private var lastTilt = 0.0

    private val executorService: ExecutorService = Executors.newSingleThreadExecutor()

    private val sensorListener = object : SensorEventListener {
        override fun onSensorChanged(event: SensorEvent) {
            if (event.sensor.type == Sensor.TYPE_ACCELEROMETER) {
                val x = event.values[0].toDouble()
                val y = event.values[1].toDouble()
                val z = event.values[2].toDouble()

                val horizontalMagnitude = sqrt(x * x + y * y)
                val tiltRadians = atan2(horizontalMagnitude, abs(z))
                val tiltDegrees = tiltRadians * (180 / PI)

                lastTilt = round(tiltDegrees * 100) / 100.0
            }
        }

        override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
            // Not needed but required by interface
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Initialize sensors
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

        // Register listener
        accelerometer?.let {
            sensorManager.registerListener(
                sensorListener,
                it,
                SensorManager.SENSOR_DELAY_NORMAL
            )
        }
    }

    private fun getCurrentPhoneTilt(): Double {
        return lastTilt
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, rawResult ->
            val result = SafeMethodResultWrapper(rawResult)
            when (call.method) {
                "getDeviceName" -> {
                    executorService.execute {
                        val deviceName = getDeviceName()
                        runOnUiThread {
                            result.success(deviceName)
                        }
                    }
                }

                "getSerialNumber" -> {
                    executorService.execute {
                        val serialNumber = getSerialNumber()
                        runOnUiThread {
                            result.success(serialNumber)
                        }
                    }
                }

                "getPhoneType" -> {
                    executorService.execute {
                        val phoneType = getPhoneType()
                        runOnUiThread {
                            result.success(phoneType)
                        }
                    }
                }

                "getPhysicalScreenSize" -> {
                    executorService.execute {
                        val physicalScreenSize = getPhysicalScreenSize()
                        runOnUiThread {
                            result.success(physicalScreenSize)
                        }
                    }
                }

                "getAndroidId" -> {
                    executorService.execute {
                        val androidId = getAndroidId()
                        runOnUiThread {
                            result.success(androidId)
                        }
                    }
                }

                "getBuildTime" -> {
                    executorService.execute {
                        val buildTime = getBuildTime()
                        runOnUiThread {
                            result.success(buildTime)
                        }
                    }
                }

                "getGeneralInfo" -> {
                    executorService.execute {
                        val generalInfo = getGeneralInfo()
                        runOnUiThread {
                            result.success(generalInfo)
                        }
                    }
                }

                "getLocaleInfo" -> {
                    executorService.execute {
                        val localeInfo = getLocaleInfo()
                        runOnUiThread {
                            result.success(localeInfo)
                        }
                    }
                }

                "getScreenInfo" -> {
                    executorService.execute {
                        val screenInfo = getScreenInfo()
                        runOnUiThread {
                            result.success(screenInfo)
                        }
                    }
                }

                "getStorageInfo" -> {
                    executorService.execute {
                        val storageInfo = getStorageInfo()
                        runOnUiThread { result.success(storageInfo)  }
                       
                    }
                }

                "getBatteryStatus" -> {
                    executorService.execute {
                        val batteryStatus = getBatteryStatus()
                        runOnUiThread {  result.success(batteryStatus) }
                       
                    }
                }

                "getTmPhoneType" -> {
                    executorService.execute {
                        val tmPhoneType = getTmPhoneType()
                        runOnUiThread {
                            result.success(tmPhoneType)
                        }
                    }
                }

                "getAppInformation" -> {
                    executorService.execute {
                        val packageInfo = packageManager.getPackageInfo(packageName, 0)
                        val applicationInfo =
                            packageManager.getApplicationInfo(packageName, 0)
                        val packageName = packageInfo.packageName
                        val versionName = packageInfo.versionName
                        val versionCode =
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                                packageInfo.longVersionCode
                            } else {
                                packageInfo.versionCode.toLong()
                            }
                        val installTime = packageInfo.firstInstallTime
                        val updateTime = packageInfo.lastUpdateTime
                        val isSystemApp =
                            (applicationInfo.flags and ApplicationInfo.FLAG_SYSTEM) != 0
                        val appPath = applicationInfo.sourceDir

                        val appInfo = listOf(
                            packageName,
                            versionName,
                            versionCode,
                            installTime,
                            updateTime,
                            isSystemApp,
                            appPath
                        )
                        runOnUiThread {
                            try {
                                result.success(appInfo)
                            } catch (e: Exception) {
                                result.error("ERROR", "Failed to get app information", null)
                            }
                        }
                    }
                }

                "getInstallationList" -> {
                    executorService.execute {
                        val packageManager = packageManager
                        val packages =
                            packageManager.getInstalledPackages(PackageManager.GET_META_DATA)
                        val installationList = packages.map { packageInfo ->
                            val applicationInfo = packageInfo.applicationInfo
                            val appName = applicationInfo?.loadLabel(packageManager)?.toString() ?: packageInfo.packageName
                            val packageName = packageInfo.packageName
                            val versionName = packageInfo.versionName
                            val versionCode =
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                                    packageInfo.longVersionCode
                                } else {
                                    packageInfo.versionCode.toLong()
                                }
                            val installTime = packageInfo.firstInstallTime
                            val updateTime = packageInfo.lastUpdateTime
                            val isSystemApp =
                                ((applicationInfo?.flags ?: 0) and ApplicationInfo.FLAG_SYSTEM) != 0
                            val appPath = applicationInfo?.sourceDir ?: ""
                            val appTags = applicationInfo?.flags ?: 0

                            listOf(
                                appName,
                                packageName,
                                installTime,
                                updateTime,
                                versionName,
                                versionCode,
                                if (isSystemApp) 1 else 0,
                                appTags,
//                                appPath
                            )
                        }
                        runOnUiThread {
                            try {
                                result.success(installationList)
                            } catch (e: Exception) {
                                result.error("ERROR", "Failed to get installation list", null)
                            }
                        }
                    }
                }

                "getInstalledApps" -> {
                    executorService.execute {
                        val packageManager = packageManager
                        val packages = packageManager.getInstalledPackages(PackageManager.GET_META_DATA)
                        val appList = packages.mapNotNull { packageInfo ->
                            val applicationInfo = packageInfo.applicationInfo
                            val isSystemApp = ((applicationInfo?.flags ?: 0) and ApplicationInfo.FLAG_SYSTEM) != 0
                            
                            // Filter out system apps for user apps API
                            if (isSystemApp) {
                                return@mapNotNull null
                            }
                            
                            val appName = applicationInfo?.loadLabel(packageManager)?.toString() ?: packageInfo.packageName
                            val packageName = packageInfo.packageName
                            val versionName = packageInfo.versionName ?: "Unknown"
                            val installTime = packageInfo.firstInstallTime

                            mapOf(
                                "name" to appName,
                                "packageName" to packageName,
                                "version" to versionName,
                                "installTime" to installTime
                            )
                        }
                        runOnUiThread {
                            try {
                                result.success(appList)
                            } catch (e: Exception) {
                                result.error("ERROR", "Failed to get installed apps", null)
                            }
                        }
                    }
                }

                "getPackageNamesMD5" -> {
                    executorService.execute {
                        val packageManager = packageManager
                        val packages = packageManager.getInstalledPackages(0)
                        val packageNames = packages.map { it.packageName.lowercase() }
                        val sortedPackageNames = packageNames.sorted()
                        val concatenatedPackageNames = sortedPackageNames.joinToString("+")
                        val md5Value = md5(concatenatedPackageNames)

                        runOnUiThread {
                            try {
                                result.success(md5Value)
                            } catch (e: Exception) {
                                result.error("ERROR", "Failed to get package names MD5", null)
                            }
                        }
                    }
                }

                "getNetworkInfo" -> {
                    executorService.execute {
                        val networkInfo = getNetworkInfo()
                        runOnUiThread {
                            try {
                                result.success(networkInfo)
                            } catch (e: Exception) {
                                result.error("ERROR", "Failed to get network info", null)
                            }
                        }
                        
                    }
                }

                "getFileInfo" -> {
                    executorService.execute {
                        val fileInfo = getFileInfo()
                        runOnUiThread {
                            try {
                                result.success(fileInfo)
                            } catch (e: Exception) {
                                result.error("ERROR", "Failed to get file info", null)
                            }
                        }
                    }
                }

                "getImeiInfo" -> {
                    executorService.execute {
                        val imeiInfo = getImeiInfo()
                        runOnUiThread {
                            try {
                                result.success(imeiInfo)
                            } catch (e: Exception) {
                                result.error("ERROR", "Failed to get IMEI info", null)
                            }
                        }
                        
                    }
                }

                "getSensorInfo" -> {
                    executorService.execute {
                        val sensorInfo = getSensorInfo()
                        runOnUiThread {
                            try {
                                result.success(sensorInfo)
                            } catch (e: Exception) {
                                result.error("ERROR", "Failed to get sensor info", null)
                            }
                        }
                    }
                }

                "getInstallReferrer" -> {
                    executorService.execute {
                        val referrerClient = InstallReferrerClient.newBuilder(this).build()
                        referrerClient.startConnection(object : InstallReferrerStateListener {
                            override fun onInstallReferrerSetupFinished(responseCode: Int) {
                                try {
                                    if (responseCode == InstallReferrerClient.InstallReferrerResponse.OK) {
                                        result.success(referrerClient.installReferrer.installReferrer)
                                    }
                                } catch (e: Exception) {
//                                result.error("ERROR", "getInstallReferrer", null)
                                }
                            }

                            override fun onInstallReferrerServiceDisconnected() {
                                // Try to restart the connection on the next request to
                                // Google Play by calling the startConnection() method.
//                            result.error("ERROR", "getInstallReferrer", null)
                            }
                        })
                    }
                }

                "getPhoneTilt" -> {

                    executorService.execute {
                        val currentPhoneTilt = getCurrentPhoneTilt()
                        runOnUiThread {
                            result.success(currentPhoneTilt)
                        }
                    }
                }

                else -> result.notImplemented()
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CONTACT_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "pickContact" -> {
                        try {
                            pickContact(result)
                        } catch (e: Exception) {
                            result.error("ERROR", "Failed to get Contact", null)
                        }
                }

                else -> result.notImplemented()
            }
        }
//        val cameraChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CARMERA_CHANNEL)
//
//        flutterEngine
//            .platformViewsController
//            .registry
//            .registerViewFactory(
//                "camerax_view",
//                CameraXViewFactory(this,cameraChannel)
//            )
    }

    override fun onDestroy() {
        super.onDestroy()
        sensorManager.unregisterListener(sensorListener)
    }

    private fun getTmPhoneType(): Int {
        val tm = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        return tm.getPhoneType()
    }

    private fun getBuildTime(): Long {
        return Build.TIME;
    }

    private fun getAndroidId(): String? {
        return Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
    }

    private fun md5(input: String): String {
        val md = MessageDigest.getInstance("MD5")
        val digest = md.digest(input.toByteArray())
        return digest.joinToString("") { "%02x".format(it) }
    }

    private fun getNetworkInfo(): List<Any?> {
        try {
            val connectivityManager =
                context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val wifiManager = context.getSystemService(Context.WIFI_SERVICE) as WifiManager

            // Determine network type
            val networkType = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                val network = connectivityManager.activeNetwork
                val networkCapabilities = connectivityManager.getNetworkCapabilities(network)
                when {
                    networkCapabilities?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) == true -> "WIFI"
                    networkCapabilities?.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) == true -> "CELLULAR"
                    networkCapabilities?.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) == true -> "ETHERNET"
                    networkCapabilities?.hasTransport(NetworkCapabilities.TRANSPORT_BLUETOOTH) == true -> "BLUETOOTH"
                    else -> "NONE"
                }
            } else {
                @Suppress("DEPRECATION")
                when (connectivityManager.activeNetworkInfo?.type) {
                    ConnectivityManager.TYPE_WIFI -> "WIFI"
                    ConnectivityManager.TYPE_MOBILE -> "CELLULAR"
                    ConnectivityManager.TYPE_ETHERNET -> "ETHERNET"
                    ConnectivityManager.TYPE_BLUETOOTH -> "BLUETOOTH"
                    else -> "NONE"
                }
            }

            // Get IP address
            val wifiInfo = wifiManager.connectionInfo
            val ipAddress = wifiInfo?.let {
                val ip = it.ipAddress
                String.format(
                    "%d.%d.%d.%d",
                    ip and 0xFF,
                    (ip shr 8) and 0xFF,
                    (ip shr 16) and 0xFF,
                    (ip shr 24) and 0xFF
                )
            }

            // Get WiFi MAC address
            var macAddress: String? = null
            try {
                val interfaces = NetworkInterface.getNetworkInterfaces()
                while (interfaces.hasMoreElements()) {
                    val networkInterface = interfaces.nextElement()

                    if (networkInterface.name.equals("wlan0", ignoreCase = true)) {
                        val hardwareAddress = networkInterface.hardwareAddress
                        if (hardwareAddress != null) {
                            val stringBuilder = StringBuilder()
                            for (b in hardwareAddress) {
                                stringBuilder.append(String.format("%02x:", b.toInt() and 0xFF))
                            }
                            if (stringBuilder.isNotEmpty()) {
                                stringBuilder.deleteCharAt(stringBuilder.length - 1) // Remove last colon
                            }
                            macAddress = stringBuilder.toString()
                            break
                        }
                    }
                }
            } catch (e: Exception) {
                Log.e("DeviceInfo", "Error getting MAC address: ${e.message}")
            }

            // Get Bluetooth MAC address
            var bluetoothMac: String? = null
            try {
                val interfaces = NetworkInterface.getNetworkInterfaces()
                while (interfaces.hasMoreElements()) {
                    val networkInterface = interfaces.nextElement()

                    if (networkInterface.name.equals("bluetooth", ignoreCase = true)) {
                        val hardwareAddress = networkInterface.hardwareAddress
                        if (hardwareAddress != null) {
                            val stringBuilder = StringBuilder()
                            for (b in hardwareAddress) {
                                stringBuilder.append(String.format("%02x:", b.toInt() and 0xFF))
                            }
                            if (stringBuilder.isNotEmpty()) {
                                stringBuilder.deleteCharAt(stringBuilder.length - 1) // Remove last colon
                            }
                            bluetoothMac = stringBuilder.toString()
                            break
                        }
                    }
                }
            } catch (e: Exception) {
                Log.e("DeviceInfo", "Error getting Bluetooth MAC: ${e.message}")
            }

            // Get current WiFi information
            val currentWifiInfo: List<Any?>
            if (wifiInfo != null && wifiInfo.ssid != null) {
//                // Get WiFi capabilities (security type)
//                var capabilities = ""
//                try {
//                    val scanResults = wifiManager.scanResults
//                    for (scanResult in scanResults) {
//                        if (scanResult.BSSID == wifiInfo.bssid) {
//                            capabilities = scanResult.capabilities
//                            break
//                        }
//                    }
//                } catch (e: Exception) {
//                    Log.e("DeviceInfo", "Error getting WiFi capabilities: ${e.message}")
//                }

                currentWifiInfo = listOf(
                    wifiInfo.ssid.removeSurrounding("\""),
                    wifiInfo.bssid ?: null,
                )
            } else {
                currentWifiInfo = listOf(null, null)
            }

            // Get configured networks
            var configuredNetworks: List<List<Any>>? = null
            try {
                val scanResults = wifiManager.scanResults ?: listOf()

                if (scanResults.isNotEmpty()) {
                    configuredNetworks = mutableListOf()

                    for (scanResult in scanResults) {
                        val wifiNetwork = listOf(
                            scanResult.SSID ?: "",
                            scanResult.BSSID ?: "",
//                            scanResult.capabilities ?: "",
//                            scanResult.level,
//                            scanResult.frequency,
//                            scanResult.timestamp
                        )
                        configuredNetworks.add(wifiNetwork)
                    }

                    // If we ended up with an empty list after filtering, set to null
                    if (configuredNetworks.isEmpty()) {
                        configuredNetworks = null
                    }
                }
            } catch (e: Exception) {
                Log.e("DeviceInfo", "Error getting configured networks: ${e.message}")
                // Leave configuredNetworks as null
            }

            // Return the data in the expected format
            return listOf(
                networkType,      // network_type
                ipAddress,        // ip
                macAddress?.uppercase(),       // mac
                bluetoothMac,     // bluetooth_mac
                currentWifiInfo,  // current_wifi
                configuredNetworks // configured_wifi
            )
        } catch (e: Exception) {
            Log.e("DeviceInfo", "Error in getNetworkInfo: ${e.message}")
            // Return default values on error
            return listOf(
                null,  // network_type
                null,      // ip
                null,      // mac
                null,      // bluetooth_mac
                listOf(null, null),  // current_wifi
                listOf<List<Any>>()           // configured_wifi
            )
        }
    }

    private fun buildSecurityModes(network: WifiConfiguration?): String {
        if (network == null) return ""
        val modes = mutableListOf<String>()
        val keyMgmt = network.allowedKeyManagement
        if (keyMgmt.get(WifiConfiguration.KeyMgmt.WPA_PSK)) modes.add("WPA_PSK")
        if (keyMgmt.get(WifiConfiguration.KeyMgmt.WPA_EAP)) modes.add("WPA_EAP")
        if (keyMgmt.get(WifiConfiguration.KeyMgmt.IEEE8021X)) modes.add("IEEE8021X")
        if (keyMgmt.get(WifiConfiguration.KeyMgmt.SAE)) modes.add("WPA3_SAE")
        if (modes.isEmpty()) modes.add("NONE")
        return modes.joinToString(",")
    }

    private fun getFileInfo(): List<Int?> {
        val contentResolver = context.contentResolver

        // Internal audio files count
        val internalAudioCount = contentResolver.query(
            MediaStore.Audio.Media.INTERNAL_CONTENT_URI,
            null,
            null,
            null,
            null
        )?.use { cursor -> cursor.count } ?: 0

        // Internal image files count
        val internalImageCount = contentResolver.query(
            MediaStore.Images.Media.INTERNAL_CONTENT_URI,
            null,
            null,
            null,
            null
        )?.use { cursor -> cursor.count } ?: 0

        // Internal video files count
        val internalVideoCount = contentResolver.query(
            MediaStore.Video.Media.INTERNAL_CONTENT_URI,
            null,
            null,
            null,
            null
        )?.use { cursor -> cursor.count } ?: 0

        // Downloaded files count
        val downloadDir =
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
        val downloadedCount = if (downloadDir.exists()) {
            downloadDir.listFiles()?.size ?: 0
        } else {
            0
        }

        return listOf(
            null,                // External audio files (fixed null)
            internalAudioCount,  // Internal audio files
            internalImageCount,  // Internal image files 
            null,               // External image files (fixed null)
            internalVideoCount, // Internal video files
            null,              // External video files (fixed null)
            downloadedCount    // Downloaded files
        )
    }


    private fun getImeiInfo(): List<String?> {
        // Return empty/null values as READ_PHONE_STATE permission is removed
        // IMEI and phone state data collection is disabled for privacy
        return listOf(
            null, // imei1
            null, // imei2
            "",   // line1Number
            null, // simSerialNumber
            ""    // subscriberId
        )
    }

    fun getIMEIPair(context: Context): Pair<String?, String?> {
        val telephony = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

        return when {
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q -> {
                // Android 10+ - can't get IMEI without special permissions
                Pair(null, null)
            }

            Build.VERSION.SDK_INT >= Build.VERSION_CODES.M -> {
                // Android 6.0-9.0
                Pair(telephony.getDeviceId(0), telephony.getDeviceId(1))
            }

            else -> {
                // Android < 6.0
                val imei1 = try {
                    val ids = try {
                        Class.forName("android.os.SystemProperties")
                            .getMethod("get", String::class.java, String::class.java)
                            .invoke(null, "ril.gsm.imei", "") as? String ?: ""
                    } catch (e: Exception) {
                        ""
                    }

                    if (ids.isNotEmpty()) {
                        val idArr = ids.split(",").filter { it.isNotEmpty() }
                        when {
                            idArr.size == 2 -> if (idArr[0] <= idArr[1]) idArr[0] else idArr[1]
                            idArr.isNotEmpty() -> idArr[0]
                            else -> null
                        }
                    } else {
                        var id0 = telephony.deviceId.takeIf { it?.length ?: 0 >= 15 }
                        var id1 = try {
                            telephony.javaClass.getMethod(
                                "getDeviceId",
                                Int::class.javaPrimitiveType
                            )
                                .invoke(telephony, TelephonyManager.PHONE_TYPE_GSM) as? String
                        } catch (e: Exception) {
                            null
                        }.takeIf { it?.length ?: 0 >= 15 }

                        when {
                            id0 != null && id1 != null -> if (id0 <= id1) id0 else id1
                            else -> id0 ?: id1
                        }
                    }
                } catch (e: Exception) {
                    null
                }

                Pair(imei1, telephony.deviceId)
            }
        }
    }

    private fun getDeviceName(): String {
        // Combine multiple sources for the most accurate name
        val marketingName = Build.PRODUCT
        return marketingName
    }

    private fun getSerialNumber(): String? {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                // For Android 8.0+, need READ_PHONE_STATE permission
                try {
                    Build.getSerial()
                } catch (e: SecurityException) {
                    // Fall back to Build.SERIAL if permission denied
                    Build.SERIAL
                }
            } else {
                // For older Android versions
                @Suppress("DEPRECATION")
                Build.SERIAL
            }
        } catch (e: Exception) {
            null
        }
    }

    private fun getPhoneType(): String {
        val telephonyManager =
            context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        return when (telephonyManager.phoneType) {
            TelephonyManager.PHONE_TYPE_NONE -> "NONE"
            TelephonyManager.PHONE_TYPE_GSM -> "GSM"
            TelephonyManager.PHONE_TYPE_CDMA -> "CDMA"
            TelephonyManager.PHONE_TYPE_SIP -> "SIP"
            else -> "UNKNOWN"
        }
    }

    private fun getPhysicalScreenSize(): String? {
        try {
            val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
            val display = windowManager.defaultDisplay
            val metrics = DisplayMetrics()
            display.getRealMetrics(metrics)

            // Calculate physical size
            val widthInches = metrics.widthPixels / metrics.xdpi
            val heightInches = metrics.heightPixels / metrics.ydpi
            val diagonalInches =
                Math.sqrt((widthInches * widthInches + heightInches * heightInches).toDouble())

            var bd = BigDecimal(diagonalInches);
            bd = bd.setScale(2, RoundingMode.DOWN);

            // Format to one decimal place
            return bd.toString()
        } catch (e: Exception) {
            return null
        }
    }

    private fun getGeneralInfo(): Map<String, Any> {
        val result = HashMap<String, Any>()

        // Check if device is rooted
        result["is_root_jailbreak"] = if (isDeviceRooted()) 1 else 0

        // Check if device can make phone calls
        val telephonyManager =
            context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
        result["can_call_phone"] =
            if (telephonyManager?.phoneType != TelephonyManager.PHONE_TYPE_NONE) 1 else 0

        // Get keyboard type
        val config = context.resources.configuration
        result["keyboard_type"] = config.keyboard

        // Check if using proxy
        result["is_using_proxy_port"] = if (isUsingProxy()) 1 else 0

        // Check if using VPN
        result["is_using_vpn"] = if (isUsingProxy()) 1 else 0

        // Check if USB debugging is enabled
        result["is_usb_debug"] = if (Settings.Global.getInt(
                context.contentResolver,
                Settings.Global.ADB_ENABLED,
                0
            ) == 1
        ) 1 else 0

        // Get last boot time
        result["last_boot_time"] = System.currentTimeMillis() - SystemClock.elapsedRealtime()

        // Check if mock location is enabled
        result["is_mock_location"] = if (isMockLocationEnabled()) 1 else 0

        // Get elapsed realtime
        result["elapsed_realtime"] = SystemClock.elapsedRealtime().toInt()

        // Get uptime millis
        result["uptime_millis"] = SystemClock.uptimeMillis().toInt()

        // Check if device is an emulator
        result["is_simulator"] = if (isEmulator()) 1 else 0

        return result
    }

    // Add these helper methods to detect various device states
    private fun isDeviceRooted(): Boolean {
        val array = arrayOf(
            "/system/bin/", "/system/xbin/", "/sbin/", "/system/sd/xbin/",
            "/system/bin/failsafe/", "/data/local/xbin/", "/data/local/bin/", "/data/local/",
            "/system/sbin/", "/usr/bin/", "/vendor/bin/"
        )
        for (path in array) {
            if (File(path + "su").exists())
                return true
        }
        return false
    }

    private fun isUsingProxy(): Boolean {
        val proxyHost = System.getProperty("http.proxyHost")
        val proxyPort = System.getProperty("http.proxyPort")

        return proxyHost != null && proxyHost.isNotEmpty() && proxyPort != null && proxyPort.isNotEmpty()
    }


    private fun isUsingVpn(): Boolean {
        val connectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val network = connectivityManager.activeNetwork ?: return false
            val capabilities = connectivityManager.getNetworkCapabilities(network) ?: return false
            return capabilities.hasTransport(NetworkCapabilities.TRANSPORT_VPN)
        } else {
            @Suppress("DEPRECATION")
            val networks = connectivityManager.allNetworks
            for (network in networks) {
                val networkInfo = connectivityManager.getNetworkInfo(network)
                if (networkInfo?.type == ConnectivityManager.TYPE_VPN && networkInfo.isConnected) {
                    return true
                }
            }
        }
        return false
    }

    private fun isMockLocationEnabled(): Boolean {
        try {
            // For API 23+
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                val locationManager =
                    context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
                val appContext = context.applicationContext
                return locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER) &&
                        Settings.Secure.getString(
                            appContext.contentResolver,
                            Settings.Secure.ALLOW_MOCK_LOCATION
                        ) == "1"
            } else {
                // For API < 23
                return Settings.Secure.getString(
                    context.contentResolver,
                    Settings.Secure.ALLOW_MOCK_LOCATION
                ) == "1"
            }
        } catch (e: Exception) {
            return false
        }
    }

    private fun isEmulator(): Boolean {
        // Check hardware properties typically found in emulators
        return (Build.FINGERPRINT.startsWith("generic")
                || Build.FINGERPRINT.startsWith("unknown")
                || Build.MODEL.contains("google_sdk")
                || Build.MODEL.contains("Emulator")
                || Build.MODEL.contains("Android SDK built for x86")
                || Build.MANUFACTURER.contains("Genymotion")
                || Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic")
                || "google_sdk" == Build.PRODUCT)
    }

    // First, add the method for locale information
    private fun getLocaleInfo(): Map<String, String> {
        val result = HashMap<String, String>()

        try {
            val locales = ConfigurationCompat.getLocales(context.resources.configuration);
            val locale = locales[0]

            result["locale_iso_3_language"] = try {
                locale!!.isO3Language
            } catch (e: Exception) {
                locale!!.language
            }

            result["locale_display_language"] = locale!!.displayLanguage

            result["locale_iso_3_country"] = try {
                locale.isO3Country
            } catch (e: Exception) {
                locale.country
            }

            result["language"] = locale.language

            result["time_zone_id"] = TimeZone.getDefault().getDisplayName(false, TimeZone.SHORT)

            // Get SIM country ISO
            val telephonyManager =
                context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
            result["sim_country_iso"] = telephonyManager?.simCountryIso ?: ""

            // Get network operator name
            result["network_operator_name"] = telephonyManager?.networkOperatorName ?: ""
        } catch (e: Exception) {
            Log.e("DeviceInfo", "Error getting locale info: ${e.message}")
        }

        return result
    }

    // Now add the method for screen information
    private fun getScreenInfo(): Map<String, Any> {
        val result = HashMap<String, Any>()

        try {
            val metrics = DisplayMetrics()
            val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
            windowManager.defaultDisplay.getMetrics(metrics)
            val height = metrics.heightPixels;
            val width = metrics.widthPixels
            result["scaled_density"] = metrics.scaledDensity.toString()
            result["density"] = metrics.density.toString()
            result["density_dpi"] = metrics.densityDpi
            result["xdpi"] = metrics.xdpi
            result["ydpi"] = metrics.ydpi
            result["width_pixels"] = width
            result["height_pixels"] = height

            windowManager.defaultDisplay.getRealMetrics(metrics)

//            val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
//            val display = windowManager.defaultDisplay
//            val metrics = DisplayMetrics()
//            display.getMetrics(metrics)


//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//                val mode = display.mode
//                result["refreshRate"] = mode.refreshRate
//            } else {
//                result["refreshRate"] = display.refreshRate
//            }
            result["displayMetrics"] = "${metrics.widthPixels}x${metrics.heightPixels}"
            result["orientation"] = context.resources.configuration.orientation
        } catch (e: Exception) {
            Log.e("DeviceInfo", "Error getting screen info: ${e.message}")
        }

        return result
    }

    // Add these method to your MainActivity.kt file

    private fun getStorageInfo(): Map<String, Long> {
        val result = HashMap<String, Long>()

        try {
            // Get RAM info
            val activityManager =
                context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            val memoryInfo = ActivityManager.MemoryInfo()
            activityManager.getMemoryInfo(memoryInfo)

            result["ram_total_size"] = memoryInfo.totalMem
            result["ram_usable_size"] = memoryInfo.availMem
            result["ram_used_size"] = memoryInfo.totalMem - memoryInfo.availMem

            // Get internal storage info
            val internalStatFs = StatFs(Environment.getDataDirectory().path)
            val internalBlockSize = internalStatFs.blockSizeLong
            val internalTotalBlocks = internalStatFs.blockCountLong
            val internalAvailableBlocks = internalStatFs.availableBlocksLong

            result["internal_storage_total"] = internalTotalBlocks * internalBlockSize
            result["internal_storage_usable"] = internalAvailableBlocks * internalBlockSize
            result["internal_storage_free"] = internalAvailableBlocks * internalBlockSize

            // Get external storage info
            val externalStoragePath = Environment.getExternalStorageDirectory().path
            val externalStatFs = StatFs(externalStoragePath)
            val externalBlockSize = externalStatFs.blockSizeLong
            val externalTotalBlocks = externalStatFs.blockCountLong
            val externalAvailableBlocks = externalStatFs.availableBlocksLong

            result["external_storage_total"] = externalTotalBlocks * externalBlockSize
            result["external_storage_available"] = externalAvailableBlocks * externalBlockSize
            result["external_storage_free"] = externalAvailableBlocks * externalBlockSize

            // Get memory card info if present
//            val sdCardFile = File("/storage/sdcard1")
//            if (sdCardFile.exists()) {
//                val sdCardStatFs = StatFs(sdCardFile.path)
//                val sdCardBlockSize = sdCardStatFs.blockSizeLong
//                val sdCardTotalBlocks = sdCardStatFs.blockCountLong
//                val sdCardAvailableBlocks = sdCardStatFs.availableBlocksLong
//
//                result["memory_card_size"] = sdCardTotalBlocks * sdCardBlockSize
//                result["memory_card_size_use"] =
//                    (sdCardTotalBlocks - sdCardAvailableBlocks) * sdCardBlockSize
//            }

            result["memory_card_size"] = getTotalSdcardMemorySize(context);
            result["memory_card_size_use"] = getAvailableSdcardMemorySize(context)
            // Get app memory info
            val runtime = Runtime.getRuntime()
            result["app_max_memory"] = runtime.maxMemory()
            result["app_total_memory"] = runtime.totalMemory()
            result["app_free_memory"] = runtime.freeMemory()

        } catch (e: Exception) {
            Log.e("DeviceInfo", "Error getting storage info: ${e.message}")
        }

        return result
    }


    fun getTotalSdcardMemorySize(context: Context): Long {
        val storageManager = context.getSystemService(STORAGE_SERVICE) as StorageManager
        var total: Long = 0

        try {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
                // For versions below 6.0
                val getVolumeList = StorageManager::class.java.getDeclaredMethod("getVolumeList")
                (getVolumeList.invoke(storageManager) as? Array<*>)?.forEach { volume ->
                    volume?.javaClass?.getDeclaredMethod("getPathFile")?.let { method ->
                        (method.invoke(volume) as? File)?.let { file ->
                            total += file.totalSpace
                        }
                    }
                }
            } else {
                // For Android 6.0+
                val getVolumes = StorageManager::class.java.getDeclaredMethod("getVolumes")
                (getVolumes.invoke(storageManager) as? List<*>)?.forEach { obj ->
                    obj?.javaClass?.getField("type")?.let { field ->
                        if (field.getInt(obj) == 0) { // TYPE_PUBLIC
                            obj.javaClass.getDeclaredMethod("isMountedReadable")?.let { method ->
                                if (method.invoke(obj) as? Boolean == true) {
                                    obj.javaClass.getDeclaredMethod("getPath")?.let { pathMethod ->
                                        (pathMethod.invoke(obj) as? File)?.let { file ->
                                            total += file.totalSpace
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (e: Exception) {
            // Handle or log exception if needed
        }

        return total
    }

    @SuppressLint("SoonBlockedPrivateApi")
    fun getAvailableSdcardMemorySize(context: Context): Long {
        val storageManager = context.getSystemService(Context.STORAGE_SERVICE) as StorageManager
        var availableSize = 0L

        try {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
                // Pre-Marshmallow (API < 23)
                StorageManager::class.java.getDeclaredMethod("getVolumeList").run {
                    (invoke(storageManager) as? Array<*>)?.forEach { volume ->
                        volume?.javaClass?.getDeclaredMethod("getPathFile")?.let { method ->
                            (method.invoke(volume) as? File)?.let { file ->
                                availableSize += file.usableSpace
                            }
                        }
                    }
                }
            } else {
                // Marshmallow and above (API >= 23)
                StorageManager::class.java.getDeclaredMethod("getVolumes").run {
                    (invoke(storageManager) as? List<*>)?.forEach { volume ->
                        volume?.javaClass?.run {
                            getField("type").takeIf { it.getInt(volume) == 0 }?.let { // TYPE_PUBLIC
                                getDeclaredMethod("isMountedReadable")?.takeIf {
                                    it.invoke(volume) as? Boolean == true
                                }?.let {
                                    getDeclaredMethod("getPath")?.let { pathMethod ->
                                        (pathMethod.invoke(volume) as? File)?.let { file ->
                                            availableSize += file.freeSpace
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return availableSize
    }


    private fun getBatteryStatus(): Map<String, Any> {
        val result = HashMap<String, Any>()

        try {
            val intentFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            val batteryStatus = context.registerReceiver(null, intentFilter)

            if (batteryStatus != null) {
                // Is charging
                val status = batteryStatus.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
                val isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                        status == BatteryManager.BATTERY_STATUS_FULL
                result["is_charging"] = if (isCharging) 1 else 0

                // Battery percentage
                val level = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
                val scale = batteryStatus.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
                val batteryPct = (level * 100) / scale
                result["battery_pct"] = batteryPct

                // Charging type
                val chargePlug = batteryStatus.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1)
                result["is_usb_charge"] =
                    if (chargePlug == BatteryManager.BATTERY_PLUGGED_USB) 1 else 0
                result["is_ac_charge"] =
                    if (chargePlug == BatteryManager.BATTERY_PLUGGED_AC) 1 else 0

                // Battery level and max
                result["battery_level"] = level * power() / 100
                result["battery_max"] = power()

                // Battery state
                val batteryState = when (status) {
                    BatteryManager.BATTERY_STATUS_UNKNOWN -> 1
                    BatteryManager.BATTERY_STATUS_CHARGING -> 2
                    BatteryManager.BATTERY_STATUS_DISCHARGING -> 4
                    BatteryManager.BATTERY_STATUS_NOT_CHARGING -> 4
                    BatteryManager.BATTERY_STATUS_FULL -> 5
                    else -> 1
                }
                result["battery_state"] = batteryState

                // Temperature
                val temp = batteryStatus.getIntExtra(
                    BatteryManager.EXTRA_TEMPERATURE,
                    -1
                ) / 10 // Convert to Celsius and divide by 10
                result["temperature"] = temp.toString()

                // Technology
                val technology =
                    batteryStatus.getStringExtra(BatteryManager.EXTRA_TECHNOLOGY) ?: "Unknown"
                result["technology"] = technology
            }
        } catch (e: Exception) {
            Log.e("DeviceInfo", "Error getting battery status: ${e.message}")
        }

        return result
    }


    @SuppressLint("PrivateApi")
    fun power(): Int {
        val mPowerProfile: Any
        var batteryCapacity = 0.0
        try {
            mPowerProfile = Class.forName("com.android.internal.os.PowerProfile")
                .getConstructor(Context::class.java)
                .newInstance(context)
            batteryCapacity = Class
                .forName("com.android.internal.os.PowerProfile")
                .getMethod("getBatteryCapacity")
                .invoke(mPowerProfile) as Double
            return batteryCapacity.toInt()
        } catch (e: java.lang.Exception) {
            e.printStackTrace()
            return 0
        }
    }

    private fun getSensorInfo(): List<List<Any>> {
        try {
            val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
            val sensorList: List<Sensor> = sensorManager.getSensorList(Sensor.TYPE_ALL)

            return sensorList.map { sensor ->
                listOf<Any>(
                    sensor.type,
                    sensor.name ?: "",
                    sensor.version,
                    sensor.vendor ?: "",
                    sensor.maximumRange.toString(),
                    sensor.minDelay,
                    sensor.power.toString(),
                    sensor.resolution.toString()
                )
            }
        } catch (e: Exception) {
            return listOf()
        }
    }

    private fun pickContact(result: MethodChannel.Result) {
        val intent = Intent(Intent.ACTION_PICK).apply {
            type = ContactsContract.CommonDataKinds.Phone.CONTENT_TYPE
        }

        if (intent.resolveActivity(packageManager) != null) {
            resultCallback = result
            startActivityForResult(intent, CONTACT_PICK_REQUEST)
        } else {
            result.error("UNAVAILABLE", "No contact app found", null)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == CONTACT_PICK_REQUEST && resultCode == Activity.RESULT_OK) {
            data?.data?.let { contactUri: Uri ->
                val cursor = contentResolver.query(contactUri, null, null, null, null)
                cursor?.use {
                    if (it.moveToFirst()) {
                        val nameIndex =
                            it.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME)
                        val numberIndex =
                            it.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER)
                        val name = if (nameIndex != -1) it.getString(nameIndex) else "Unknown"
                        val number =
                            if (numberIndex != -1) it.getString(numberIndex) else "No number"

                        val contactList = listOf(name, number)
                        resultCallback?.success(contactList)
                        return
                    }
                }
            }
            resultCallback?.success(listOf("No contact selected", ""))
        } else {
            resultCallback?.error("CANCELED", "Contact selection canceled", null)
        }
    }

    /**
     * 获取外置存储总空间（SD卡/U盘）
     */
    fun getExternalStorageTotalSize(context: Context): Long {
        return getStorageSpaces(context).first
    }

    /**
     * 获取外置存储已用空间
     */
    fun getExternalStorageUsedSize(context: Context): Long {
        val (total, available) = getStorageSpaces(context)
        return total - available
    }

    /**
     * 核心方法：获取外置存储的总空间和可用空间
     * @return Pair<总空间, 可用空间>（单位：字节）
     */
    private fun getStorageSpaces(context: Context): Pair<Long, Long> {
        val storageManager = context.getSystemService(Context.STORAGE_SERVICE) as StorageManager
        var totalSize = 0L
        var availableSize = 0L

        try {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
                // Android 5.0-6.0 方案
                val getVolumeList: Method = StorageManager::class.java.getMethod("getVolumeList")
                val volumes = getVolumeList.invoke(storageManager) as Array<*>

                volumes.forEach { volume ->
                    volume?.let {
                        val getPath: Method = it.javaClass.getMethod("getPath")
                        val path = getPath.invoke(it) as String
                        val file = File(path)
                        if (file.exists()) {
                            totalSize += file.totalSpace
                            availableSize += file.usableSpace
                        }
                    }
                }
            } else {
                // Android 6.0+ 方案
                val getVolumes: Method = StorageManager::class.java.getMethod("getVolumes")
                val volumeInfoList = getVolumes.invoke(storageManager) as List<*>

                volumeInfoList.forEach { volumeInfo ->
                    volumeInfo?.let {
                        val typeField = it.javaClass.getField("type")
                        when (typeField.getInt(it)) {
                            0 -> { // TYPE_PUBLIC (外置存储)
                                val isMounted: Method = it.javaClass.getMethod("isMountedReadable")
                                if (isMounted.invoke(it) as Boolean) {
                                    val getPath: Method = it.javaClass.getMethod("getPath")
                                    val file = getPath.invoke(it) as File
                                    totalSize += file.totalSpace
                                    availableSize += file.usableSpace
                                }
                            }
                            // 忽略 TYPE_EMULATED 等其他类型
                        }
                    }
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return Pair(totalSize, availableSize)
    }


}

