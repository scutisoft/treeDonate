package com.scutisoft.treedonate;

import io.flutter.embedding.android.FlutterFragmentActivity;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.os.Bundle;
public class MainActivity extends FlutterFragmentActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE);
    }
}

