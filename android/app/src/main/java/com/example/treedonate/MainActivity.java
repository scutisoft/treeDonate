package com.scutisoft.treedonate;

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.embedding.engine.FlutterEngine;
import androidx.annotation.NonNull;
import androidx.core.content.FileProvider;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.util.Log;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.os.Bundle;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

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
               File file=new File(String.valueOf(data.get(i)));

               Uri apkURI = FileProvider.getUriForFile(this, this.getApplicationContext().getPackageName() + ".provider", file);
               this.grantUriPermission(this.getApplicationContext().getPackageName(),apkURI,Intent.FLAG_GRANT_READ_URI_PERMISSION);
               imageUris.add(apkURI);
           }

           Intent shareIntent = new Intent();
          /* List<ResolveInfo> resInfoList = this.getPackageManager().queryIntentActivities(shareIntent, PackageManager.MATCH_DEFAULT_ONLY);
           for(Uri uri:imageUris){
               for (ResolveInfo resolveInfo : resInfoList) {
                   String packageName = resolveInfo.activityInfo.packageName;
                   this.grantUriPermission(packageName, uri, Intent.FLAG_GRANT_WRITE_URI_PERMISSION | Intent.FLAG_GRANT_READ_URI_PERMISSION);
               }
           }*/

           shareIntent.setAction(Intent.ACTION_SEND_MULTIPLE);
           shareIntent.putExtra(Intent.EXTRA_SUBJECT,"EXTRA_SUBJECT");
           shareIntent.putExtra(Intent.EXTRA_TEXT,"EXTRA_TEXT");
           //ArrayList<CharSequence> extra_text = new ArrayList<CharSequence>();
           //extra_text.add("S");
          // extra_text.add("E");
           //shareIntent.putCharSequenceArrayListExtra(Intent.EXTRA_TEXT,extra_text);
          // shareIntent.putStringArrayListExtra(Intent.EXTRA_TEXT, extra_text);
           shareIntent.putParcelableArrayListExtra(Intent.EXTRA_STREAM, imageUris);
           shareIntent.setType("image/*");
           shareIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
           this.startActivity(Intent.createChooser(shareIntent, "Hii"));
       }catch (Exception e){
           Log.d(e.toString(),e.toString());
       }

    }
}

