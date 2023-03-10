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

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

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
                            else if (call.method.equals("openShare")){
                              //  call.arguments();
                                openShare(String.valueOf(call.arguments));
                               /* ArrayList<String> imageUris = new ArrayList<String>();
                                imageUris= (ArrayList<String>) call.arguments;
                                for(int i=0;i<imageUris.size();i++){
                                    Log.d("openShare",imageUris.get(i));
                                }*/
                               // Log.d("openShare", String.valueOf(call.arguments));
                            }
                        }
                );
    }

    private String helloFromNativeCode() {
        return "Hello from Native Android Code";
    }

    private void openShare(String pathJson){
       try{
           ArrayList<Uri> imageUris = new ArrayList<Uri>();
           JSONArray data = new JSONArray(pathJson);
           for (int i = 0; i < data.length(); i++) {
               Log.d("openShare"+ i, String.valueOf(data.get(i)));
               imageUris.add(Uri.parse(String.valueOf(data.get(i))));
           }

           Intent shareIntent = new Intent();
           shareIntent.setAction(Intent.ACTION_SEND_MULTIPLE);
           shareIntent.putParcelableArrayListExtra(Intent.EXTRA_STREAM, imageUris);
           shareIntent.setType("image/*");
           this.startActivity(Intent.createChooser(shareIntent, "Hii"));
       }catch (Exception e){
           Log.d(e.toString(),e.toString());
       }

    }
}

