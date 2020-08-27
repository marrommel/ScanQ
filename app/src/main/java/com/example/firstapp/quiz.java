package com.example.firstapp;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.room.Room;
import androidx.room.migration.Migration;
import androidx.sqlite.db.SupportSQLiteDatabase;

import com.google.android.material.button.MaterialButton;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Random;

public class quiz extends AppCompatActivity {

    private TextView points, sucsess, countR, countW;
    private LinearLayout ll1;
    private LinearLayout ll2;
    private LinearLayout ll3;
    private LinearLayout ll4;
    private MaterialButton restart;
    private CardView questionCard, resultCard;

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

        points = findViewById(R.id.points);
        sucsess = findViewById(R.id.succsess);
        countR = findViewById(R.id.countRight);
        countW = findViewById(R.id.countWrong);
        final TextView voc = findViewById(R.id.voc);
        ll1 = findViewById(R.id.ll1);
        ll2 = findViewById(R.id.ll2);
        ll3 = findViewById(R.id.ll3);
        ll4 = findViewById(R.id.ll4);
        questionCard = findViewById(R.id.questionCard1);
        resultCard = findViewById(R.id.resultCard1);
        resultCard.setVisibility(View.GONE);
        ImageButton previous = findViewById(R.id.quizleft);
        ImageButton next = findViewById(R.id.quizright);
        restart = findViewById(R.id.restart1);

        final SharedPreferences mySPR = quiz.this.getPreferences(Context.MODE_PRIVATE);
        final SharedPreferences.Editor editor = mySPR.edit();

        final TextView question = findViewById(R.id.question);
        question.setText("Welche Übersetzung passt?");
        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().addMigrations(MIGRATION_1_2).build();
        List<Vokabel> list = db.vokabelnDao().getAlle();
        this.vocabList.addAll(list);

        final MaterialButton answer1 = new MaterialButton(this);
        final MaterialButton answer2 = new MaterialButton(this);
        final MaterialButton answer3 = new MaterialButton(this);
        final MaterialButton answer4 = new MaterialButton(this);
        final MaterialButton[] answers = {answer1, answer2, answer3, answer4};

        for(int i=0; i<4; i++) {
            answers[i].setPadding(
                    (int) convertDpToPixels(this, 25),
                    (int) convertDpToPixels(this, 18),
                    (int) convertDpToPixels(this, 25),
                    (int) convertDpToPixels(this, 18));
            answers[i].setClickable(true);
            answers[i].setFocusable(true);
            answers[i].setTextColor(Color.parseColor("#ffffff"));
            answers[i].setBackgroundColor(Color.parseColor("#219a95"));
            answers[i].setTextSize((int) convertDpToPixels(this, 9));
            answers[i].setCornerRadius((int) convertDpToPixels(this, 6));
        }
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

                final int vocId = db.vokabelnDao().getId(String.valueOf(vocabList.get(newVoc).getVokabelDE()));
                final int answered = db.vokabelnDao().getAnswered(vocId);
                List<Vokabel> list = db.vokabelnDao().getAlle();
                List<Vokabel> vocabList = new ArrayList<>(list);
                String rightVoc = vocabList.get(newVoc).getVokabelENG();
                int id = vocabList.get(newVoc).getId();
                for (int i = 0; i < 3; i++) {
                    wrongVoc.add(getFalscheAntwortEn(rightVoc));
                }

                voc.setText(vocabList.get(newVoc).getVokabelDE());
                answer3.setTag(id);
                answer1.setText(wrongVoc.get(0));
                answer2.setText(wrongVoc.get(1));
                answer3.setText(rightVoc);
                answer4.setText(wrongVoc.get(2));

                final boolean markiert = db.vokabelnDao().isMarkiert(voc.getText().toString());
                if(markiert) {
                    voc.setTextColor(Color.parseColor("#FF00FF"));
                } else {
                    voc.setTextColor(Color.parseColor("#219a95"));
                }

                if(answered == 0) {
                    answer1.setBackgroundColor(Color.parseColor("#219a95"));
                    answer2.setBackgroundColor(Color.parseColor("#219a95"));
                    answer3.setBackgroundColor(Color.parseColor("#219a95"));
                    answer4.setBackgroundColor(Color.parseColor("#219a95"));
                    answer1.setClickable(true);
                    answer2.setClickable(true);
                    answer3.setClickable(true);
                    answer4.setClickable(true);
                } else if(answered == 1){
                    answer1.setBackgroundColor(Color.parseColor("#990000"));
                    answer2.setBackgroundColor(Color.parseColor("#999999"));
                    answer3.setBackgroundColor(Color.parseColor("#009900"));
                    answer4.setBackgroundColor(Color.parseColor("#999999"));
                    answer1.setClickable(false);
                    answer2.setClickable(false);
                    answer3.setClickable(false);
                    answer4.setClickable(false);
                } else if(answered == 2){
                    answer1.setBackgroundColor(Color.parseColor("#999999"));
                    answer2.setBackgroundColor(Color.parseColor("#990000"));
                    answer3.setBackgroundColor(Color.parseColor("#009900"));
                    answer4.setBackgroundColor(Color.parseColor("#999999"));
                    answer1.setClickable(false);
                    answer2.setClickable(false);
                    answer3.setClickable(false);
                    answer4.setClickable(false);
                } else if(answered == 3){
                    answer1.setBackgroundColor(Color.parseColor("#999999"));
                    answer2.setBackgroundColor(Color.parseColor("#999999"));
                    answer3.setBackgroundColor(Color.parseColor("#009900"));
                    answer4.setBackgroundColor(Color.parseColor("#999999"));
                    answer1.setClickable(false);
                    answer2.setClickable(false);
                    answer3.setClickable(false);
                    answer4.setClickable(false);
                } else if(answered == 4){
                    answer1.setBackgroundColor(Color.parseColor("#999999"));
                    answer2.setBackgroundColor(Color.parseColor("#999999"));
                    answer3.setBackgroundColor(Color.parseColor("#009900"));
                    answer4.setBackgroundColor(Color.parseColor("#990000"));
                    answer1.setClickable(false);
                    answer2.setClickable(false);
                    answer3.setClickable(false);
                    answer4.setClickable(false);
                }

                final List<Vokabel> alreadyAnswered = db.vokabelnDao().getAlreadyAnswered(0);
                if (alreadyAnswered.size() == 0) {
                    quizResult();
                    for (int i = 0; i < 4; i++) {
                        answers[i].setVisibility(View.GONE);
                    }
                }
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

                final int vocId = db.vokabelnDao().getId(String.valueOf(vocabList.get(newVoc).getVokabelDE()));
                final int answered = db.vokabelnDao().getAnswered(vocId);

                List<Vokabel> list = db.vokabelnDao().getAlle();
                List<Vokabel> vocabList = new ArrayList<>(list);
                String rightVoc = vocabList.get(newVoc).getVokabelENG();
                int id = vocabList.get(newVoc).getId();
                for (int i = 0; i < 3; i++) {
                    wrongVoc.add(getFalscheAntwortEn(rightVoc));
                }

                voc.setText(vocabList.get(newVoc).getVokabelDE());
                answer3.setTag(id);
                answer1.setText(wrongVoc.get(0));
                answer2.setText(wrongVoc.get(1));
                answer3.setText(rightVoc);
                answer4.setText(wrongVoc.get(2));

                final boolean markiert = db.vokabelnDao().isMarkiert(voc.getText().toString());
                if(markiert) {
                    voc.setTextColor(Color.parseColor("#FF00FF"));
                } else {
                    voc.setTextColor(Color.parseColor("#219a95"));
                }

                if(answered == 0) {
                    answer1.setBackgroundColor(Color.parseColor("#219a95"));
                    answer2.setBackgroundColor(Color.parseColor("#219a95"));
                    answer3.setBackgroundColor(Color.parseColor("#219a95"));
                    answer4.setBackgroundColor(Color.parseColor("#219a95"));
                    answer1.setClickable(true);
                    answer2.setClickable(true);
                    answer3.setClickable(true);
                    answer4.setClickable(true);
                } else if(answered == 1){
                    answer1.setBackgroundColor(Color.parseColor("#990000"));
                    answer2.setBackgroundColor(Color.parseColor("#999999"));
                    answer3.setBackgroundColor(Color.parseColor("#009900"));
                    answer4.setBackgroundColor(Color.parseColor("#999999"));
                    answer1.setClickable(false);
                    answer2.setClickable(false);
                    answer3.setClickable(false);
                    answer4.setClickable(false);
                } else if(answered == 2){
                    answer1.setBackgroundColor(Color.parseColor("#999999"));
                    answer2.setBackgroundColor(Color.parseColor("#990000"));
                    answer3.setBackgroundColor(Color.parseColor("#009900"));
                    answer4.setBackgroundColor(Color.parseColor("#999999"));
                    answer1.setClickable(false);
                    answer2.setClickable(false);
                    answer3.setClickable(false);
                    answer4.setClickable(false);
                } else if(answered == 3){
                    answer1.setBackgroundColor(Color.parseColor("#999999"));
                    answer2.setBackgroundColor(Color.parseColor("#999999"));
                    answer3.setBackgroundColor(Color.parseColor("#009900"));
                    answer4.setBackgroundColor(Color.parseColor("#999999"));
                    answer1.setClickable(false);
                    answer2.setClickable(false);
                    answer3.setClickable(false);
                    answer4.setClickable(false);
                } else if(answered == 4){
                    answer1.setBackgroundColor(Color.parseColor("#999999"));
                    answer2.setBackgroundColor(Color.parseColor("#999999"));
                    answer3.setBackgroundColor(Color.parseColor("#009900"));
                    answer4.setBackgroundColor(Color.parseColor("#990000"));
                    answer1.setClickable(false);
                    answer2.setClickable(false);
                    answer3.setClickable(false);
                    answer4.setClickable(false);
                }

                final List<Vokabel> alreadyAnswered = db.vokabelnDao().getAlreadyAnswered(0);
                if (alreadyAnswered.size() == 0) {
                    quizResult();
                    for (int i = 0; i < 4; i++) {
                        answers[i].setVisibility(View.GONE);
                    }
                }
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

                final int vocId = db.vokabelnDao().getId(voc.getText().toString());
                insert(vocId, 1);
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

                final int vocId = db.vokabelnDao().getId(voc.getText().toString());
                insert(vocId, 2);
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
                final int currentpoint = mySPR.getInt("myKey1", 0);
                int newPoint = currentpoint + 1;
                points.setText(String.valueOf(newPoint));
                editor.putInt("myKey1", newPoint);
                editor.apply();

                final int vocId = db.vokabelnDao().getId(voc.getText().toString());
                insert(vocId, 3);
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

                final int vocId = db.vokabelnDao().getId(voc.getText().toString());
                insert(vocId, 4);
            }
        });

        voc.setOnLongClickListener(new View.OnLongClickListener() {
            @Override
            public boolean onLongClick(View view) {
                String[] items;
                if(!db.vokabelnDao().isMarkiert(voc.getText().toString())) {
                    items = new String[]{" Vokabel markieren", " Vokabel bearbeiten"};
                } else {
                     items = new String[]{" Markierung aufheben", " Vokabel bearbeiten"};
                }
                AlertDialog.Builder dialog = new AlertDialog.Builder(quiz.this);
                dialog.setItems(items, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if ( i == 0){
                            final boolean markiert = db.vokabelnDao().isMarkiert(voc.getText().toString());
                            if(markiert) {
                                db.vokabelnDao().updateMarkierung(voc.getText().toString(), false);
                                voc.setTextColor(Color.parseColor("#219a95"));
                                Toast.makeText(quiz.this, "Markierung erfolgreich entfernt", Toast.LENGTH_SHORT).show();
                            }
                            else {
                                db.vokabelnDao().updateMarkierung(voc.getText().toString(), true);
                                voc.setTextColor(Color.parseColor("#FF00FF"));
                                Toast.makeText(quiz.this, "Vokabel erfolgreich markiert", Toast.LENGTH_SHORT).show();
                            }
                        }
                        if( i == 1){

                        }
                    }
                });
                dialog.create().show();
                return false;
            }
        });

        restart.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                quiz.this.recreate();
                final SharedPreferences mySPR = quiz.this.getPreferences(Context.MODE_PRIVATE);
                final SharedPreferences.Editor editor = mySPR.edit();
                editor.putInt("myKey1", 0);
                editor.apply();

                final Datenbank db = Room.databaseBuilder(quiz.this, Datenbank.class, "Vokabeln").allowMainThreadQueries().addMigrations(MIGRATION_1_2).build();
                for(int i=0; i<vocabList.size(); i++) {
                    db.vokabelnDao().updateAnswered(vocabList.get(i).getId(), 0);
                    db.vokabelnDao().updateMarkierung(vocabList.get(i).getVokabelDE(), false);
                }
            }
        });
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        final SharedPreferences mySPR = quiz.this.getPreferences(Context.MODE_PRIVATE);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putInt("myKey1", 0);
        editor.apply();

        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().addMigrations(MIGRATION_1_2).build();
        for(int i=0; i<vocabList.size(); i++) {
            db.vokabelnDao().updateAnswered(vocabList.get(i).getId(), 0);
            db.vokabelnDao().updateMarkierung(vocabList.get(i).getVokabelDE(), false);
        }
    }

    @Override
    protected void onStop() {
        super.onStop();
        final SharedPreferences mySPR = quiz.this.getPreferences(Context.MODE_PRIVATE);
        final SharedPreferences.Editor editor = mySPR.edit();
        editor.putInt("myKey1", 0);
        editor.apply();

        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().addMigrations(MIGRATION_1_2).build();
        for(int i=0; i<vocabList.size(); i++) {
            db.vokabelnDao().updateAnswered(vocabList.get(i).getId(), 0);
            db.vokabelnDao().updateMarkierung(vocabList.get(i).getVokabelDE(), false);
        }
    }

    private String getFalscheAntwortEn(String richtigeAntwort) {
        String antwort;
        do {
            int index = new Random().nextInt(vocabList.size());
            antwort = vocabList.get(index).getVokabelENG();
        } while (antwort.equals(richtigeAntwort) /*|| wrongVoc.contains(antwort)*/);

        return antwort;
    }

    static final Migration MIGRATION_1_2 = new Migration(1, 2) {
        @Override
        public void migrate(SupportSQLiteDatabase database) {
            database.execSQL("ALTER TABLE Vokabeln "
                    + " ADD COLUMN answered INTEGER NOT NULL DEFAULT 0 ");
        }
    };

    private void insert(int id, int answerId) {
        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().addMigrations(MIGRATION_1_2).build();
        db.vokabelnDao().updateAnswered(id, answerId);
    }
    private void quizResult() {
        final Datenbank db = Room.databaseBuilder(this, Datenbank.class, "Vokabeln").allowMainThreadQueries().addMigrations(MIGRATION_1_2).build();
        final int rightAnswered = db.vokabelnDao().getAlreadyAnswered(3).size();
        final int wrongAnswered = vocabList.size() - rightAnswered;
        questionCard.setVisibility(View.GONE);
        resultCard.setVisibility(View.VISIBLE);
        if (rightAnswered >= wrongAnswered) {
            sucsess.setText("Gratulation!");
        } else {
            sucsess.setText("Schade!");
        }
        countR.setText(rightAnswered + " Fragen richtig");
        countW.setText(wrongAnswered + " Fragen falsch");
    }
}
