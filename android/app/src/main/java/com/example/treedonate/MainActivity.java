package com.scutisoft.treedonate;

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.embedding.engine.FlutterEngine;
import androidx.annotation.NonNull;

import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.os.Bundle;

import java.util.ArrayList;

public class MainActivity extends FlutterFragmentActivity  {

    private static final String CHANNEL = "flutter.native/helper";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE);

    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("helloFromNativeCode")){
                                String greetings = helloFromNativeCode();
                                result.success(greetings);
                            }
                        }
                );
    }

    private String helloFromNativeCode() {
        return "Hello from Native Android Code";
    }

    private void openShare(){
       try{
           ArrayList<Uri> imageUris = new ArrayList<Uri>();
           imageUris.add(Uri.parse("")); // Add your image URIs here
           // imageUris.add(imageUri2);

           Intent shareIntent = new Intent();
           shareIntent.setAction(Intent.ACTION_SEND_MULTIPLE);
           shareIntent.putParcelableArrayListExtra(Intent.EXTRA_STREAM, imageUris);
           shareIntent.setType("image/*");
           //this.startActivity(Intent.createChooser(shareIntent, null));
       }catch (Exception e){
           Log.d(e.toString(),e.toString());
       }

    }
}

