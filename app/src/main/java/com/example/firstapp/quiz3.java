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

public class quiz3 extends AppCompatActivity {
    private TextView points3;
    private EditText loesung;
    private TextInputLayout layoutloesung;
    private Button check;
    private CardView richtig;
    private CardView falsch;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.quiz3);

        points3 = (TextView) findViewById(R.id.points3);

        SharedPreferences mSPR = getSharedPreferences("point3", 0);
        final SharedPreferences.Editor editor = mSPR.edit();
        editor.putString("myKey1", "0");
        editor.apply();

        String currPoints = mSPR.getString("myKey1","");
        assert currPoints != null;
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
                int newPoint = currentPoints+1;
                if(loesung.getText().toString().toLowerCase().equals("food")){
                    layoutloesung.setVisibility(View.GONE);
                    check.setVisibility(View.GONE);
                    richtig.setVisibility(View.VISIBLE);
                    points3.setText(String.valueOf(newPoint));
                    editor.putString("myKey1", String.valueOf(newPoint));
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
        SharedPreferences mySPR = getSharedPreferences("point3", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putString("myKey1", "0");
        editor.apply();
    }

    @Override
    protected void onStop() {
        super.onStop();
        SharedPreferences mySPR = getSharedPreferences("point3", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putString("myKey1", "0");
        editor.apply();
    }
}

