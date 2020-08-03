package com.example.firstapp;

import android.annotation.SuppressLint;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import java.util.Objects;

public class quiz extends AppCompatActivity {

    private TextView points;
    private Button answer1;
    private Button answer2;
    private Button answer3;
    private Button answer4;

    @SuppressLint("SetTextI18n")
    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.quiz);

        points = (TextView) findViewById(R.id.points);

        SharedPreferences mySPR = getSharedPreferences("point", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        if(Objects.equals(mySPR.getString("myKey1", ""), "0")) {
            editor.putString("myKey1", "0");
            editor.apply();
        }
        final int currentpoint = Integer.parseInt(mySPR.getString("myKey1",""));

        TextView question = (TextView) findViewById(R.id.question);
        question.setText("Welche Übersetzung passt?");
        TextView voc = (TextView) findViewById(R.id.voc);
        voc.setText("Essen");

        answer1 = (Button) findViewById(R.id.answer1);
        answer2 = (Button) findViewById(R.id.answer2);
        answer3 = (Button) findViewById(R.id.answer3);
        answer4 = (Button) findViewById(R.id.answer4);

        ImageButton previous = (ImageButton) findViewById(R.id.quizleft);
        ImageButton next = (ImageButton) findViewById(R.id.quizright);

        String text1 = "foot";
        String text2 = "fod";
        String text3 = "food";
        String text4 = "fot";

        answer1.setText(text1);
        answer2.setText(text2);
        answer3.setText(text3);
        answer4.setText(text4);

        answer1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                answer1.setBackgroundColor(Color.parseColor("#990000"));
                answer2.setBackgroundColor(Color.parseColor("#999999"));
                answer3.setBackgroundColor(Color.parseColor("#009900"));
                answer4.setBackgroundColor(Color.parseColor("#999999"));
                answer1.setClickable(false);
                answer2.setClickable(false);
                answer3.setClickable(false);
                answer4.setClickable(false);
            }
        });

        answer2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                answer1.setBackgroundColor(Color.parseColor("#999999"));
                answer2.setBackgroundColor(Color.parseColor("#990000"));
                answer3.setBackgroundColor(Color.parseColor("#009900"));
                answer4.setBackgroundColor(Color.parseColor("#999999"));
                answer1.setClickable(false);
                answer2.setClickable(false);
                answer3.setClickable(false);
                answer4.setClickable(false);
            }
        });

        answer3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                answer1.setBackgroundColor(Color.parseColor("#999999"));
                answer2.setBackgroundColor(Color.parseColor("#999999"));
                answer3.setBackgroundColor(Color.parseColor("#009900"));
                answer4.setBackgroundColor(Color.parseColor("#999999"));
                answer1.setClickable(false);
                answer2.setClickable(false);
                answer3.setClickable(false);
                answer4.setClickable(false);
                int newPoint = currentpoint+1;
                points.setText(String.valueOf(newPoint));
                editor.putString("myKey1", String.valueOf(newPoint));
                editor.apply();
            }
        });

        answer4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                answer1.setBackgroundColor(Color.parseColor("#999999"));
                answer2.setBackgroundColor(Color.parseColor("#999999"));
                answer3.setBackgroundColor(Color.parseColor("#009900"));
                answer4.setBackgroundColor(Color.parseColor("#990000"));
                answer1.setClickable(false);
                answer2.setClickable(false);
                answer3.setClickable(false);
                answer4.setClickable(false);
            }
        });
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        SharedPreferences mySPR = getSharedPreferences("point", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putString("myKey1", "0");
        editor.apply();
    }

    @Override
    protected void onStop() {
        super.onStop();
        SharedPreferences mySPR = getSharedPreferences("point", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putString("myKey1", "0");
        editor.apply();
    }
}
