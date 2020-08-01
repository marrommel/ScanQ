package com.example.firstapp;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;

import com.google.android.material.textfield.TextInputLayout;

import java.util.Objects;

public class quiz2 extends AppCompatActivity {

    private TextView points2;
    private EditText loesung;
    private TextInputLayout layoutloesung;
    private Button check;
    private CardView richtig;
    private CardView falsch;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.quiz2);

        points2 = (TextView) findViewById(R.id.points2);

        SharedPreferences SPR = getSharedPreferences("point2", 0);
        final SharedPreferences.Editor editor = SPR.edit();
        if(Objects.equals(SPR.getString("myKey2", ""), "0")) {
            editor.putString("myKey2", "0");
            editor.apply();
        }
        String currPoints = SPR.getString("myKey2","");
        final int currentPoints = Integer.parseInt(currPoints);

        layoutloesung = (TextInputLayout) findViewById(R.id.loesungEBox);
        loesung = (EditText)findViewById(R.id.loesungE);
        check = (Button)findViewById(R.id.check);
        richtig = (CardView)findViewById(R.id.richtig);
        falsch = (CardView)findViewById(R.id.falsch);

        richtig.setVisibility(View.GONE);
        falsch.setVisibility(View.GONE);

        check.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                int newpoint = currentPoints+1;
                if(loesung.getText().toString().toLowerCase().equals("essen")){
                    layoutloesung.setVisibility(View.GONE);
                    check.setVisibility(View.GONE);
                    richtig.setVisibility(View.VISIBLE);
                    points2.setText(String.valueOf(newpoint));
                    editor.putString("myKey1", String.valueOf(newpoint));
                    editor.apply();
                }else{
                    layoutloesung.setVisibility(View.GONE);
                    check.setVisibility(View.GONE);
                    falsch.setVisibility(View.VISIBLE);
                }
            }
        });
    }
    @Override
    public void onDestroy() {
        super.onDestroy();
        SharedPreferences mySPR = getSharedPreferences("point2", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putString("myKey2", "0");
        editor.apply();
    }

    @Override
    protected void onStop() {
        super.onStop();
        SharedPreferences mySPR = getSharedPreferences("point2", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putString("myKey2", "0");
        editor.apply();
    }
}
