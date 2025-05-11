plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.uni_companion"
    compileSdk = 35  // Updated to SDK 35, as required by Firebase plugins
    ndkVersion = "27.0.12077973"  // Keep the NDK version as specified

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.uni_companion"
        minSdk = 23  // You can keep this as is, depending on your Flutter setup
        targetSdk = flutter.targetSdkVersion  // Keep this in sync with the Flutter target SDK version
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Ensure that the Firebase plugin is applied to your project
apply(plugin = "com.google.gms.google-services")

flutter {
    source = "../.."  // Keep this as it is, to point to the Flutter project source
}
