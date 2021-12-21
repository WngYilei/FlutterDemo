package com.xl.xl_eyepetozer;

import static io.flutter.view.FlutterMain.startInitialization;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import io.flutter.embedding.android.FlutterActivity;
public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // +添加 startInitialization调用
        startInitialization(this.getApplicationContext());
        super.onCreate(savedInstanceState);
    }
    public static void start(Context context, String page) {
        Intent intent = new Intent(context, MainActivity.class);
        intent.setAction(Intent.ACTION_RUN);
        intent.putExtra("route", page);
        context.startActivity(intent);
    }
}
