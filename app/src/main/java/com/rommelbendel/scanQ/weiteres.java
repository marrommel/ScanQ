package com.rommelbendel.scanQ;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import java.util.Objects;

public class weiteres extends AppCompatActivity {

    private EditText edit1;
    private TextView text1;
    private Button button;
    private TextView text2;
    private Button button2;

    @SuppressLint("SetTextI18n")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        edit1 = (EditText) findViewById(R.id.edit1);
        text1 = (TextView) findViewById(R.id.text1);
        button = (Button) findViewById(R.id.button);
        text2 = (TextView) findViewById(R.id.text2);
        button2 = (Button) findViewById(R.id.button2);

        text2.setVisibility(View.GONE);

        button.setOnClickListener(new OnClickListener() {
            public void onClick(View view) {
                SharedPreferences mySPR = getSharedPreferences("MySPFILE", 0);

                SharedPreferences.Editor editor = mySPR.edit();
                editor.putString("myKey1",edit1.getText().toString());
                editor.apply();

                Intent myIntent = new Intent(weiteres.this, Haupt.class);
                weiteres.this.startActivity(myIntent);
            }
        });

        text1.setText("Wer bist du?");
        SharedPreferences mySPR = getSharedPreferences("MySPFILE", 0);
        if(!Objects.equals(mySPR.getString("myKey1", ""), "")) {
            text1.setText("Hallo " + mySPR.getString("myKey1", "") + " !");
            edit1.setVisibility(View.GONE);
            button.setVisibility(View.GONE);
            text2.setVisibility(View.VISIBLE);
            text2.setText("Du bist nicht " + mySPR.getString("myKey1", "") + " ?");
            button2.setVisibility(View.VISIBLE);
        }

        button2.setOnClickListener(new OnClickListener() {
            public void onClick(View view) {
                text1.setText("Wer bist du?");
                edit1.setVisibility(View.VISIBLE);
                button.setVisibility(View.VISIBLE);
                text2.setVisibility(View.GONE);
                button2.setVisibility(View.GONE);
            }
        });
    }
}