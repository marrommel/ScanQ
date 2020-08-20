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
import androidx.room.Room;

import com.google.android.material.button.MaterialButton;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Random;

public class quiz extends AppCompatActivity {

    private TextView points;
    private LinearLayout ll1;
    private LinearLayout ll2;
    private LinearLayout ll3;
    private LinearLayout ll4;

    private List<String> wrongVoc = new ArrayList<>();

    private final List<Vokabel> vocabList = new ArrayList<>();

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
        final TextView voc = (TextView) findViewById(R.id.voc);
        ll1 = findViewById(R.id.ll1);
        ll2 = findViewById(R.id.ll2);
        ll3 = findViewById(R.id.ll3);
        ll4 = findViewById(R.id.ll4);

        final SharedPreferences mySPR = getSharedPreferences("point", 0);
        final SharedPreferences.Editor editor = mySPR.edit();
        if (Objects.equals(mySPR.getString("myKey1", ""), "0")) {
            editor.putString("myKey1", "0");
            editor.apply();
        }
        final int currentpoint = Integer.parseInt(mySPR.getString("myKey1", ""));

        final TextView question = (TextView) findViewById(R.id.question);
        question.setText("Welche Übersetzung passt?");
        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().build();
        List<Vokabel> list = db.vokabelnDao().getAlle();
        this.vocabList.addAll(list);
        voc.setText(vocabList.get(0).getVokabelENG());

        final MaterialButton answer1 = new MaterialButton(this);
        answer1.setPadding(
                (int) convertDpToPixels(this, 25),
                (int) convertDpToPixels(this, 18),
                (int) convertDpToPixels(this, 25),
                (int) convertDpToPixels(this, 18));
        answer1.setClickable(true);
        answer1.setFocusable(true);
        answer1.setTextColor(Color.parseColor("#ffffff"));
        answer1.setBackgroundColor(Color.parseColor("#219a95"));
        answer1.setTextSize((int) convertDpToPixels(this, 9));
        answer1.setCornerRadius((int) convertDpToPixels(this, 6));
        final MaterialButton answer2 = new MaterialButton(this);
        answer2.setPadding(
                (int) convertDpToPixels(this, 25),
                (int) convertDpToPixels(this, 18),
                (int) convertDpToPixels(this, 25),
                (int) convertDpToPixels(this, 18));
        answer2.setClickable(true);
        answer2.setFocusable(true);
        answer2.setTextColor(Color.parseColor("#ffffff"));
        answer2.setBackgroundColor(Color.parseColor("#219a95"));
        answer2.setTextSize((int) convertDpToPixels(this, 9));
        answer2.setCornerRadius((int) convertDpToPixels(this, 6));
        final MaterialButton answer3 = new MaterialButton(this);
        answer3.setPadding(
                (int) convertDpToPixels(this, 25),
                (int) convertDpToPixels(this, 18),
                (int) convertDpToPixels(this, 25),
                (int) convertDpToPixels(this, 18));
        answer3.setClickable(true);
        answer3.setFocusable(true);
        answer3.setTextColor(Color.parseColor("#ffffff"));
        answer3.setBackgroundColor(Color.parseColor("#219a95"));
        answer3.setTextSize((int) convertDpToPixels(this, 9));
        answer3.setCornerRadius((int) convertDpToPixels(this, 6));
        final MaterialButton answer4 = new MaterialButton(this);
        answer4.setPadding(
                (int) convertDpToPixels(this, 25),
                (int) convertDpToPixels(this, 18),
                (int) convertDpToPixels(this, 25),
                (int) convertDpToPixels(this, 18));
        answer4.setClickable(true);
        answer4.setFocusable(true);
        answer4.setTextColor(Color.parseColor("#ffffff"));
        answer4.setBackgroundColor(Color.parseColor("#219a95"));
        answer4.setTextSize((int) convertDpToPixels(this, 9));
        answer4.setCornerRadius((int) convertDpToPixels(this, 6));

        ImageButton previous = findViewById(R.id.quizleft);
        ImageButton next = findViewById(R.id.quizright);

        final SharedPreferences sharedPref = quiz.this.getPreferences(Context.MODE_PRIVATE);
        final SharedPreferences.Editor edit = sharedPref.edit();
        edit.putInt("vocKey1", 0);
        edit.apply();
        next.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ll1.removeAllViewsInLayout();
                ll2.removeAllViewsInLayout();
                ll3.removeAllViewsInLayout();
                ll4.removeAllViewsInLayout();
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


                final int currentvoc = sharedPref.getInt("vocKey1", 0);
                int newVoc = currentvoc + 1;
                if(newVoc >= vocabList.size()) {
                    newVoc = 0;
                }
                edit.putInt("vocKey1", newVoc);
                edit.apply();

                List<Vokabel> list = db.vokabelnDao().getAlle();
                List<Vokabel> vocabList = new ArrayList<>(list);

                String rightVoc = vocabList.get(newVoc).getVokabelENG();

                //List vokabelList = new VokabelSpender(quiz.this, null).getQuizFrageENG();
                for (int i = 0; i < 3; i++) {
                    wrongVoc.add(getFalscheAntwortEn(rightVoc));
                }

                voc.setText(vocabList.get(newVoc).getVokabelDE());
                answer1.setText(wrongVoc.get(0));
                answer2.setText(wrongVoc.get(1));
                answer3.setText(rightVoc);
                answer4.setText(wrongVoc.get(2));
            }
        });

        previous.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ll1.removeAllViewsInLayout();
                ll2.removeAllViewsInLayout();
                ll3.removeAllViewsInLayout();
                ll4.removeAllViewsInLayout();

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

                final int currentvoc = sharedPref.getInt("vocKey1", 0);
                int newVoc = currentvoc - 1;
                if(newVoc < 0) {
                   newVoc = vocabList.size()-1;
                }
                edit.putInt("vocKey1", newVoc);
                edit.apply();

                List vokabelList = new VokabelSpender(quiz.this, vocabList.get(newVoc).getKategorie()).getQuizFrageENG();

                voc.setText((String) vokabelList.get(0));
                answer1.setText((String) vokabelList.get(2));
                answer2.setText((String) vokabelList.get(3));
                answer3.setText((String) vokabelList.get(1));
                answer4.setText((String) vokabelList.get(4));
            }
        });

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

    private String getFalscheAntwortEn(String richtigeAntwort) {
        String antwort;
        do {
            int index = new Random().nextInt(vocabList.size());
            antwort = vocabList.get(index).getVokabelENG();
        } while (antwort.equals(richtigeAntwort) || wrongVoc.contains(antwort));

        return antwort;
    }
}
