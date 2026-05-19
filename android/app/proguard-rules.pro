# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Web Socket Channel
-keep class com.neovisionaries.ws.client.** { *; }
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**

# Keep models (important for JSON serialization)
-keep class com.mdSoft.cubit_pro.featuers.chat_bot.models.** { *; }
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# General networking
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn java.lang.SafeVarargs
