package com.flappy.flutterflappytoast;

import android.view.Gravity;
import android.widget.Toast;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterflappytoastPlugin
 */
public class FlutterflappytoastPlugin implements FlutterPlugin, MethodCallHandler {

    //吐司
    private Toast toast;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        //附加到引擎
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutterflappytoast");
        //创建toast
        toast = Toast.makeText(flutterPluginBinding.getApplicationContext(), "", Toast.LENGTH_SHORT);
        //设置handler
        channel.setMethodCallHandler(this);
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    public static void registerWith(Registrar registrar) {
        //toast
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutterflappytoast");
        //控件
        FlutterflappytoastPlugin plugin = new FlutterflappytoastPlugin();
        //创建吐司
        plugin.toast = Toast.makeText(registrar.activity(), "", Toast.LENGTH_SHORT);
        //设置handler
        channel.setMethodCallHandler(plugin);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("showToast")) {
            //最大的长度
            String toastStr = call.argument("toast");
            //设置位置
            String gravity = call.argument("gravity");
            //设置位置
            if (Integer.parseInt(gravity) == 0) {
                toast.setGravity(Gravity.BOTTOM, 0, 0);
            }
            if (Integer.parseInt(gravity) == 1) {
                toast.setGravity(Gravity.CENTER, 0, 0);
            }
            if (Integer.parseInt(gravity) == 2) {
                toast.setGravity(Gravity.TOP, 0, 0);
            }
            //设置吐司字符串
            toast.setText(toastStr);
            //显示
            toast.show();
            //返回成功
            result.success("true");
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }
}
