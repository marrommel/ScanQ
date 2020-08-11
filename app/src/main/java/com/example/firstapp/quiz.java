package com.example.firstapp;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.google.android.material.button.MaterialButton;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Objects;

public class quiz extends AppCompatActivity {

    private TextView points;
    private LinearLayout ll1;
    private LinearLayout ll2;
    private LinearLayout ll3;
    private LinearLayout ll4;

    float convertDpToPixels(Context context, int dp) {
        return (int) (dp * context.getResources().getDisplayMetrics().density);
    }

    @SuppressLint("SetTextI18n")
    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.quiz);

        points = (TextView) findViewById(R.id.points);
        TextView voc = (TextView) findViewById(R.id.voc);
        ll1 = findViewById(R.id.ll1);
        ll2 = findViewById(R.id.ll2);
        ll3 = findViewById(R.id.ll3);
        ll4 = findViewById(R.id.ll4);

        SharedPreferences mySPR = getSharedPreferences("point", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        if (Objects.equals(mySPR.getString("myKey1", ""), "0")) {
            editor.putString("myKey1", "0");
            editor.apply();
        }
        final int currentpoint = Integer.parseInt(mySPR.getString("myKey1", ""));

        final TextView question = (TextView) findViewById(R.id.question);
        question.setText("Welche Übersetzung passt?");

        final MaterialButton answer1 = new MaterialButton(this);
        answer1.setPadding((int) convertDpToPixels(this, 35),
                (int) convertDpToPixels(this, 14),
                (int) convertDpToPixels(this, 35),
                (int) convertDpToPixels(this, 14));
        answer1.setClickable(true);
        answer1.setFocusable(true);
        answer1.setTextColor(Color.parseColor("#ffffff"));
        answer1.setBackgroundColor(Color.parseColor("#219a95"));
        answer1.setTextSize((int) convertDpToPixels(this, 12));
        answer1.setCornerRadius((int) convertDpToPixels(this, 6));
        final MaterialButton answer2 = new MaterialButton(this);
        answer2.setPadding((int) convertDpToPixels(this, 35),
                (int) convertDpToPixels(this, 14),
                (int) convertDpToPixels(this, 35),
                (int) convertDpToPixels(this, 14));
        answer2.setClickable(true);
        answer2.setFocusable(true);
        answer2.setTextColor(Color.parseColor("#ffffff"));
        answer2.setBackgroundColor(Color.parseColor("#219a95"));
        answer2.setTextSize((int) convertDpToPixels(this, 12));
        answer2.setCornerRadius((int) convertDpToPixels(this, 6));
        final MaterialButton answer3 = new MaterialButton(this);
        answer3.setPadding((int) convertDpToPixels(this, 35),
                (int) convertDpToPixels(this, 14),
                (int) convertDpToPixels(this, 35),
                (int) convertDpToPixels(this, 14));
        answer3.setClickable(true);
        answer3.setFocusable(true);
        answer3.setTextColor(Color.parseColor("#ffffff"));
        answer3.setBackgroundColor(Color.parseColor("#219a95"));
        answer3.setTextSize((int) convertDpToPixels(this, 12));
        answer3.setCornerRadius((int) convertDpToPixels(this, 6));
        final MaterialButton answer4 = new MaterialButton(this);
        answer4.setPadding((int) convertDpToPixels(this, 35),
                (int) convertDpToPixels(this, 14),
                (int) convertDpToPixels(this, 35),
                (int) convertDpToPixels(this, 14));
        answer4.setClickable(true);
        answer4.setFocusable(true);
        answer4.setTextColor(Color.parseColor("#ffffff"));
        answer4.setBackgroundColor(Color.parseColor("#219a95"));
        answer4.setTextSize((int) convertDpToPixels(this, 12));
        answer4.setCornerRadius((int) convertDpToPixels(this, 6));

        final View[] answers = {answer1, answer2, answer3, answer4};
        final ArrayList result = new ArrayList(4);
        for (int i = 0; i < 4; ++i) {
            result.add(i);
        }
        Collections.shuffle(result);

        ll1.addView(answers[(int) result.get(0)]);
        ll2.addView(answers[(int) result.get(1)]);
        ll3.addView(answers[(int) result.get(2)]);
        ll4.addView(answers[(int) result.get(3)]);

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
                int newPoint = currentpoint + 1;
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
