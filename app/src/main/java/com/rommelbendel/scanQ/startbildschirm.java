package com.rommelbendel.scanQ;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.rommelbendel.scanQ.impaired.visually.ReadOut;

import java.util.Objects;

public class startbildschirm extends AppCompatActivity {
    public final int ladezeit = 2000;

    @SuppressLint("SetTextI18n")
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.startbildschirm);

        @ReadOut(position = 0) TextView text3 = (TextView) findViewById(R.id.text3);

        SharedPreferences mySPR = getSharedPreferences("MySPFILE", 0);
        if(!Objects.equals(mySPR.getString("myKey1", ""), "")) {
            text3.setText("Hey " + mySPR.getString("myKey1", "") + "!");
            //@ReadOut(position = 0) String greetingText = text3.getText().toString();

            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    Intent myIntent = new Intent(startbildschirm.this, home.class);
                    startbildschirm.this.startActivity(myIntent);
                    finish();
                }
            },ladezeit);
        }else if(Objects.equals(mySPR.getString("myKey1", ""), "")){
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    Intent myIntent = new Intent(startbildschirm.this, weiteres.class);
                    startbildschirm.this.startActivity(myIntent);
                    finish();
                }
            },ladezeit);
        }
    }
}
